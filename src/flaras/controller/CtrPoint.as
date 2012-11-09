/**
 * FLARAS - Flash Augmented Reality Authoring System
 * --------------------------------------------------------------------------------
 * Copyright (C) 2011-2012 Raryel, Hipolito, Claudio
 * 
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 * 
 * --------------------------------------------------------------------------------
 * Developers:
 * Raryel Costa Souza - raryel.costa[at]gmail.com
 * Hipolito Douglas Franca Moreira - hipolitodouglas[at]gmail.com
 * 
 * Advisor: Claudio Kirner - ckirner[at]gmail.com
 * http://www.ckirner.com/flaras
 * Developed at UNIFEI - Federal University of Itajuba (www.unifei.edu.br) - Minas Gerais - Brazil
 * Research scholarship by FAPEMIG - Fundação de Amparo à Pesquisa no Estado de Minas Gerais
 */

package flaras.controller
{
	import flaras.*;
	import flaras.controller.audio.*;
	import flaras.controller.constants.*;
	import flaras.controller.io.*;
	import flaras.controller.io.fileReader.*;
	import flaras.controller.util.Point3D;
	import flaras.model.*;
	import flaras.model.point.*;
	import flaras.model.scene.*;
	import flaras.view.point.*;
	import flash.filesystem.*;
	import org.papervision3d.core.math.*;
	
	public class CtrPoint
	{
		private var _listOfPoints:Vector.<Point> = new Vector.<Point>();
		private var _listOfBoundaryPoints:Vector.<ViewPoint> = new Vector.<ViewPoint>();
		private var _listOfCtrScenes:Vector.<CtrScene> = new Vector.<CtrScene>();
		
		private var nListOfScenesAlreadyLoaded:uint;
		
		private var _ctrMain:CtrMain;
		
		public function CtrPoint(ctrMain:CtrMain)
		{
			this._ctrMain = ctrMain;
		}
		
		public function resetAllScenesPosition():void
		{
			for each (var ctr:CtrScene in _listOfCtrScenes) 
			{
				ctr.resetAllScenesPosition();
			}
		}
		
		public function destroyListOfPoints():void
		{
			if (this._listOfPoints.length != 0)
			{
				for each(var p:Point in this._listOfPoints)
				{
					destroyPointInfo(p, false); 
				}
				this._listOfPoints = new Vector.<Point>();
				this._listOfBoundaryPoints = new Vector.<ViewPoint>();
				this._listOfCtrScenes = new Vector.<CtrScene>();
			}			
		}
		
		private function destroyPointInfo(p:Point, removeFiles:Boolean):void
		{
			var bndPoint:ViewPoint;
			var f:File;
			var indexScene:uint;
			
			if (!removeFiles)
			{
				for (indexScene = 0; indexScene < p.getListOfFlarasScenes().length; indexScene++) 
				{
					getCtrScene(p.getID()).destroyScene(indexScene);
				}
			}
			else
			{
				for (indexScene = 0; indexScene < p.getListOfFlarasScenes().length; indexScene++) 
				{
					getCtrScene(p.getID()).removeScene(indexScene);
				}
				
				//removing the xml file with the object list
				f = new File(FolderConstants.getFlarasAppCurrentFolder() + "/" + p.getFilePathListOfObjects());
				if (f.exists)
				{
					FileRemover.remove(f.nativePath);
				}
			}
			
			bndPoint = _listOfBoundaryPoints[p.getID()];
			bndPoint.destroy();
			bndPoint = null;
			p.destroy();
			p = null;			
		}
		
		public function loadProjectData():void
		{			
			new FileReaderListOfPoints(FolderConstants.getFlarasAppCurrentFolder() + "/" + XMLFilesConstants.LIST_OF_POINTS_PATH, this);
		}
		
		public function finishedReadingListOfPoints():void
		{
			nListOfScenesAlreadyLoaded = 0;
		}		
		
		public function finishedReadingListOfScenes():void
		{
			nListOfScenesAlreadyLoaded++;
			if (nListOfScenesAlreadyLoaded == _listOfPoints.length)
			{
				this._ctrMain.ctrGUI.initProjectTree();
				enableAllPoints(false);
			}
		}
		
		public function getListOfPoints():Vector.<Point>
		{
			return this._listOfPoints;
		}
		
		public function getNumberOfPoints():uint
		{
			return _listOfPoints.length;
		}
		
		public function getCtrScene(indexPoint:uint):CtrScene
		{
			return _listOfCtrScenes[indexPoint];
		}
		
		public function getLabel(indexPoint:uint):String
		{
			return _listOfPoints[indexPoint].getLabel();
		}
		
		public function getPosition(indexPoint:uint):Number3D
		{
			return _listOfPoints[indexPoint].getPosition();	
		}
		
		public function getMoveInteractionForScenes(indexPoint:uint):Boolean
		{
			return _listOfPoints[indexPoint].isMoveInteractionForScenes();
		}
		
		// functions related with adding and removing points -----------------------------------------------------------
		public function addPointFromXML(pPosition:Number3D, pLabel:String, pMoveInteractionForScenes:Boolean):void
		{
			var p:Point;
			
			p = addPoint(pPosition, pLabel, pMoveInteractionForScenes, true);
			
			//read the list of objects associated to the point p
			new FileReaderListOfObjects(p.getID(), FolderConstants.getFlarasAppCurrentFolder() + "/" + p.getFilePathListOfObjects(), this);
		}
		
		public function addPoint(pPosition:Number3D, pLabel:String, pMoveInteractionForScenes:Boolean, pFromXML:Boolean=false):Point
		{
			var p:Point;
			
			if (!pFromXML)
			{
				_ctrMain.ctrUserProject.setUnsavedModifications(true);
			}			
			
			p = new Point(this._listOfPoints.length, pPosition, pLabel, pMoveInteractionForScenes)
			this._listOfPoints.push(p);
			this._listOfBoundaryPoints.push(new ViewPoint(p, _ctrMain));
			this._listOfCtrScenes.push(new CtrScene(_ctrMain, p));
			
			return p;
		}
		
		public function removePoint(indexPoint:uint):void
		{
			var id:uint;
			var p:Point;
			
			_ctrMain.ctrUserProject.setUnsavedModifications(true);
			
			p = _listOfPoints[indexPoint];
			
			id = p.getID()
			destroyPointInfo(p, true);
			
			//removing from the lists
			this._listOfPoints.splice(id, 1);
			this._listOfBoundaryPoints.splice(id, 1);
			this._listOfCtrScenes.splice(id, 1);
			
			//regenerating the point IDs
			id = 0;
			for each(p in this._listOfPoints)
			{
				p.setID(id);
				id++;
			}
		}
		// end of functions related with adding and removing points -----------------------------------------------------------
		
		public function updatePointLabel(indexPoint:uint, pLabel:String):void
		{
			var p:Point;
			
			_ctrMain.ctrUserProject.setUnsavedModifications(true);
			
			p = _listOfPoints[indexPoint];
			p.setLabel(pLabel);
		}
		
		public function updatePointMoveInteractionForScenes(indexPoint:uint, moveInteractionForScenes:Boolean):void
		{
			var p:Point;
			
			_ctrMain.ctrUserProject.setUnsavedModifications(true);
			
			p = _listOfPoints[indexPoint];
			p.setMoveInteractionForScenes(moveInteractionForScenes);
		}
		
		public function updatePointPosition(indexPoint:uint, position:Number3D):void
		{
			var bndPoint:ViewPoint;
			var p:Point;
			
			_ctrMain.ctrUserProject.setUnsavedModifications(true);
			
			p = _listOfPoints[indexPoint];
			
			bndPoint = _listOfBoundaryPoints[p.getID()];		
			p.setPosition(position);
			bndPoint.setPosition(position);
				
			for (var i:int = 0; i < p.getListOfFlarasScenes().length ; i++) 
			{
				getCtrScene(p.getID()).updateReloadPointPosition(i);
			}
		}

		//functions related with navigating through the list of objects -------------------------------------------------------------
		public function inspectPoint(p:Point):void
		{			
			if (p.isEnabled())
			{
				disablePoint(p, true);
			}
			else
			{
				enablePoint(p, true, true);
			}
		}
		
		public function controlPoint(p:Point, pDirection:int):void
		{
			var indexActiveObject:int;
			var listOfScenes:Vector.<FlarasScene>;
		
			if (p.isEnabled())
			{
				listOfScenes = getCtrScene(p.getID()).getListOfFlarasScenes();
				indexActiveObject = p.getIndexActiveScene();
				getCtrScene(p.getID()).disableScene(indexActiveObject);
				
				p.setIndexActiveScene(indexActiveObject + pDirection)
				indexActiveObject = p.getIndexActiveScene();
				
				if (pDirection == CtrMarker.CONTROL_FORWARD)
				{
					AudioManager.playSystemAudio(SystemFilesPathsConstants.AUDIO_PATH_CONTROL_INTERACTION_FORWARD);
				}
				else
				{
					AudioManager.playSystemAudio(SystemFilesPathsConstants.AUDIO_PATH_CONTROL_INTERACTION_BACKWARD);
				}
				
				if (indexActiveObject > listOfScenes.length - 1)
				{
					p.setIndexActiveScene(0);
				}
				else
				{
					if (indexActiveObject < 0)
					{
						p.setIndexActiveScene(listOfScenes.length - 1);
					}
				}
				
				getCtrScene(p.getID()).enableScene(p.getIndexActiveScene(), true);
			}			
		}
		
		public function goToScene(indexPoint:int, pSceneIndex:uint):void
		{
			var p:Point = this._listOfPoints[indexPoint];
			
			if (!p.isEnabled())
			{
				enablePointUI(indexPoint);
			}
			
			getCtrScene(p.getID()).disableScene(p.getIndexActiveScene());
			
			p.setIndexActiveScene(pSceneIndex);
			getCtrScene(p.getID()).enableScene(pSceneIndex, true);
			
		}
		//end of functions related with navigating through the list of objects -------------------------------------------------------------
		
		// functions related with enabling and disabling points
		private function enablePoint(p:Point, pPlayAudio:Boolean, pPlaySystemAudio:Boolean, pShowScene:Boolean = true):void
		{			
			var listOfFlarasScenes:Vector.<FlarasScene>;
			var bndPoint:ViewPoint;
			
			bndPoint = _listOfBoundaryPoints[p.getID()];
			bndPoint.hidePointSphere();
			
			p.setEnabled(true);
			
			if (pPlaySystemAudio)
			{
				AudioManager.playSystemAudio(SystemFilesPathsConstants.AUDIO_PATH_ENABLE);
			}			
			
			if (pShowScene)
			{
				listOfFlarasScenes = p.getListOfFlarasScenes();
				if (listOfFlarasScenes.length > 0)
				{
					p.setIndexActiveScene(p.getIndexLastActiveScene());
				
					getCtrScene(p.getID()).enableScene(p.getIndexActiveScene(), pPlayAudio);
				}
			}			
		}
		
		public function enablePointUI(indexPoint:int):void
		{
			var p:Point = this._listOfPoints[indexPoint];
			var bndPoint:ViewPoint;
			
			bndPoint = _listOfBoundaryPoints[p.getID()];			
			bndPoint.showAxis();
			//bndPoint.hidePointSphere();
			//p.setEnabled(true);
			enablePoint(p, false, false, false);
		}
		
		private function disablePoint(p:Point, pPlayAudio:Boolean):void
		{
			var bndPoint:ViewPoint;
			
			bndPoint = _listOfBoundaryPoints[p.getID()];

			if (!bndPoint.isAxisVisible())
			{
				bndPoint.showPointSphere();
			}
			
			p.setEnabled(false);
			
			if (pPlayAudio)
			{
				AudioManager.playSystemAudio(SystemFilesPathsConstants.AUDIO_PATH_DISABLE);
			}			
			
			if (p.getListOfFlarasScenes().length > 0)
			{
				p.setIndexLastActiveScene(p.getIndexActiveScene());
				
				getCtrScene(p.getID()).disableScene(p.getIndexActiveScene());
			}
		}	
		
		public function enableAllPoints(pPlaySystemAudio:Boolean):void
		{
			for each(var p:Point in this._listOfPoints)
			{
				if (!p.isEnabled())
				{
					enablePoint(p,false,pPlaySystemAudio);
				}
			}
		}
		
		public function disableAllPoints(pPlayAudio:Boolean):void
		{
			for each(var p:Point in this._listOfPoints)
			{
				if (p.isEnabled())
				{
					disablePoint(p, pPlayAudio);
				}
			}
		}
		
		public function disableAllPointsUI():void
		{
			var bndPoint:ViewPoint;
						
			for each(var p:Point in this._listOfPoints)
			{
				bndPoint = _listOfBoundaryPoints[p.getID()];				
				bndPoint.hideAxis();
				disablePoint(p, false);
			}
		}
		//end of functions related with enabling and disabling points
		
		public function toggleMirrorPointsScenes():void
		{
			for each (var p:Point in _listOfPoints) 
			{
				getCtrScene(p.getID()).toggleMirrorScenes();
			}
		}
		//end of functions related with navigating through the list of objects -------------------------------------------------------------
	}		
}