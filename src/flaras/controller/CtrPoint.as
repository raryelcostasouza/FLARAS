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
	import flaras.audio.*;
	import flaras.boundary.*;
	import flaras.constants.*;
	import flaras.entity.*;
	import flaras.entity.object3D.*;
	import flaras.io.*;
	import flaras.io.fileReader.*;
	import flaras.marker.*;
	import flaras.model.*;
	import flash.filesystem.*;
	import org.papervision3d.core.math.*;
	
	public class CtrPoint
	{
		private var _listOfPoints:Vector.<Point> = new Vector.<Point>();
		private var _listOfBoundaryPoints:Vector.<BoundaryPoint> = new Vector.<BoundaryPoint>();
		private var _listOfCtrScenes:Vector.<CtrListOfObjects> = new Vector.<CtrListOfObjects>();
		
		private var _ctrMain:CtrMain;
		
		public function CtrPoint(ctrMain:CtrMain)
		{
			this._ctrMain = ctrMain;
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
				this._listOfBoundaryPoints = new Vector.<BoundaryPoint>();
				this._listOfCtrScenes = new Vector.<CtrListOfObjects>();
			}			
		}
		
		private function destroyPointInfo(p:Point, removeFiles:Boolean):void
		{
			var facObj3D:FacadeObject3D;
			var bndPoint:BoundaryPoint;
			var obj3D:Object3D;
			var f:File;
			var indexScene:uint;
			
			if (!removeFiles)
			{
				for (indexScene = 0; indexScene < p.getListOfFlarasScenes().length; indexScene++) 
				{
					getCtrListOfObjects(p.getID()).unLoadScene(indexScene);
				}
			}
			else
			{
				for (indexScene = 0; indexScene < p.getListOfFlarasScenes().length; indexScene++) 
				{
					getCtrListOfObjects(p.getID()).removeScene(indexScene);
				}
				
				/*for each(obj3D in p.getListOfScenes())
				{
					facObj3D = new FacadeObject3D(obj3D);
					facObj3D.unLoadAndRemoveFile(AudioDecorator.REMOVE_AUDIO_FILE);
				}*/
				
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
			p = null;			
		}
		
		public function loadProjectData():void
		{			
			new FileReaderListOfPoints(FolderConstants.getFlarasAppCurrentFolder() + "/" + XMLFilesConstants.LIST_OF_POINTS_PATH, this);
		}
		
		public function finishedReadingListOfPoints():void
		{
			this._ctrMain.ctrGUI.comboBoxReload();
		}		
		
		public function getListOfPoints():Vector.<Point>
		{
			return this._listOfPoints;
		}
		
		public function getCtrListOfObjects(indexPoint:uint):CtrListOfObjects
		{
			return _listOfCtrScenes[indexPoint];
			//return new CtrListOfObjects(this._listOfPoints[indexPoint]);
		}
		
		// functions related with adding and removing points -----------------------------------------------------------
		public function addPointFromXML(pPosition:Number3D):void
		{
			var p:Point;
			
			p = addPoint(pPosition);
			/*p = new Point(this._listOfPoints.length, pPosition);
			this._listOfPoints.push(p);
			this._listOfBoundaryPoints.push(new BoundaryPoint(p.getPosition()));
			this._listOfCtrScenes.push(new CtrListOfObjects(p));*/
			
			//read the list of objects associated to the point p
			new FileReaderListOfObjects(p.getID(), FolderConstants.getFlarasAppCurrentFolder() + "/" + p.getFilePathListOfObjects(), this);
		}
		
		public function addPoint(pPosition:Number3D):Point
		{
			var p:Point;
			
			p = new Point(this._listOfPoints.length, pPosition)
			this._listOfPoints.push(p);
			this._listOfBoundaryPoints.push(new BoundaryPoint(p.getPosition()));
			this._listOfCtrScenes.push(new CtrListOfObjects(p));
			
			return p;
		}
		
		public function removePoint(p:Point):void
		{
			var id:uint;
			
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
		
		public function updatePointPosition(p:Point, position:Number3D):void
		{
			var facObj3D:FacadeObject3D;
			var bndPoint:BoundaryPoint;
			
			bndPoint = _listOfBoundaryPoints[p.getID()];		
			p.setPosition(position);
			bndPoint.setPosition(position);
				
			for (var i:int = 0; i < p.getListOfFlarasScenes().length ; i++) 
			{
				getCtrListOfObjects(p.getID()).updateReloadPointPosition(i);
			}
			/*for each(var obj3D:Object3D in p.getListOfScenes())
			{
				facObj3D = new FacadeObject3D(obj3D);
				facObj3D.updateObject3DPosition();
			}*/
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
			var listObjects:Vector.<Object3D>;
			
			if (p.isEnabled())
			{
				//listObjects = p.getListOfScenes();
				indexActiveObject = p.getIndexActiveScene();
				getCtrListOfObjects(p.getID()).disableScene(indexActiveObject);
				
				/*var obj3D:Object3D = listObjects[indexActiveObject];
				obj3D.disableObject();*/
				
				p.setIndexActiveScene(indexActiveObject + pDirection)
				indexActiveObject = p.getIndexActiveScene();
				
				if (indexActiveObject > listObjects.length - 1)
				{
					p.setIndexActiveScene(0);
				}
				else
				{
					if (indexActiveObject < 0)
					{
						p.setIndexActiveScene(listObjects.length - 1);
					}
				}
				
				getCtrListOfObjects(p.getID()).enableScene(p.getIndexActiveScene(), true);
				
				/*obj3D = listObjects[p.getIndexActiveScene()];
				obj3D.enableObject(true);*/
			}			
		}
		
		public function goToObject(indexPoint:int, pObjectIndex:uint):void
		{
			var p:Point = this._listOfPoints[indexPoint];
			var listObjects:Vector.<Object3D>;
			
			if (!p.isEnabled())
			{
				enablePointUI(indexPoint);
			}
			
			/*listObjects = p.getListOfScenes();
			var obj3D:Object3D = listObjects[p.getIndexActiveScene()];
			
			obj3D.disableObject();
			
			obj3D = listObjects[pObjectIndex];
			
			p.setIndexActiveScene(pObjectIndex);
			obj3D.enableObject(true);*/
			
			getCtrListOfObjects(p.getID()).disableScene(p.getIndexActiveScene());
			
			p.setIndexActiveScene(pObjectIndex);
			getCtrListOfObjects(p.getID()).enableScene(pObjectIndex, true);
			
		}
		//end of functions related with navigating through the list of objects -------------------------------------------------------------
		
		// functions related with enabling and disabling points
		private function enablePoint(p:Point, pPlayAudio:Boolean, pPlaySystemAudio:Boolean):void
		{			
			var obj3D:Object3D;
			//var listObjects:Vector.<Object3D>;
			var listOfFlarasScenes:Vector.<FlarasScene>;
			var bndPoint:BoundaryPoint;
			
			bndPoint = _listOfBoundaryPoints[p.getID()];
			bndPoint.hidePointSphere();
			
			p.setEnabled(true);
			
			if (pPlaySystemAudio)
			{
				AudioManager.playSystemAudio(SystemFilesPathsConstants.AUDIO_PATH_ENABLE);
			}			
			
			/*listObjects = p.getListOfScenes();
			if (listObjects.length > 0)
			{
				p.setIndexActiveScene(p.getIndexLastActiveScene());
				obj3D = listObjects[p.getIndexActiveScene()];
			
				obj3D.enableObject(pPlayAudio);
			}*/
			listOfFlarasScenes = p.getListOfFlarasScenes();
			if (listOfFlarasScenes.length > 0)
			{
				p.setIndexActiveScene(p.getIndexLastActiveScene());
				
				getCtrListOfObjects(p.getID()).enableScene(p.getIndexActiveScene(), pPlayAudio)
				/*obj3D = listObjects[p.getIndexActiveScene()];
			
				obj3D.enableObject(pPlayAudio);*/
			}
		}
		
		private function disablePoint(p:Point, pPlayAudio:Boolean):void
		{
			var obj3D:Object3D;
			var listObjects:Vector.<Object3D>;
			var bndPoint:BoundaryPoint;
			
			bndPoint = _listOfBoundaryPoints[p.getID()];

			if (!bndPoint.isAxisVisible())
			{
				bndPoint.showPointSphere();
			}
			
			bndPoint.hideAuxSphere();
			
			p.setEnabled(false);
			
			if (pPlayAudio)
			{
				AudioManager.playSystemAudio(SystemFilesPathsConstants.AUDIO_PATH_DISABLE);
			}
			
			/*listObjects = p.getListOfScenes();
			if (listObjects.length > 0)
			{
				p.setIndexLastActiveScene(p.getIndexActiveScene());
				
				obj3D = listObjects[p.getIndexActiveScene()];
				if (obj3D.isEnabled())
				{
					obj3D.disableObject();			
				}				
			}*/			
			
			
			if (p.getListOfFlarasScenes().length > 0)
			{
				p.setIndexLastActiveScene(p.getIndexActiveScene());
				
				getCtrListOfObjects(p.getID()).disableScene(p.getIndexActiveScene());
				/*obj3D = listObjects[p.getIndexActiveScene()];
				if (obj3D.isEnabled())
				{
					obj3D.disableObject();			
				}*/				
			}
		}	
		
		public function enablePointUI(indexPoint:int):void
		{
			var p:Point = this._listOfPoints[indexPoint];
			var bndPoint:BoundaryPoint;
			
			bndPoint = _listOfBoundaryPoints[p.getID()];
			
			enablePoint(p, true, false);			
			bndPoint.showAxis();
			
		}
		
		public function enableAllPoints():void
		{
			for each(var p:Point in this._listOfPoints)
			{
				if (!p.isEnabled())
				{
					enablePoint(p,false,true);
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
		
		public function disableAllPointsUI(pPlayAudio:Boolean):void
		{
			var bndPoint:BoundaryPoint;
						
			for each(var p:Point in this._listOfPoints)
			{
				bndPoint = _listOfBoundaryPoints[p.getID()];				
				bndPoint.hideAxis();
				disablePoint(p, pPlayAudio);
			}
		}
		//end of functions related with enabling and disabling points
		
		public function toggleVisibleAuxSphereOfPoints():void
		{
			var bndPoint:BoundaryPoint;
			
			for each(var p:Point in this._listOfPoints)
			{
				bndPoint = _listOfBoundaryPoints[p.getID()];
				if (p.isEnabled())
				{
					bndPoint.toggleVisibleAuxSphere();
				}				
			}
		}
		//end of functions related with navigating through the list of objects -------------------------------------------------------------
	}		
}