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
	import flaras.boundary.BoundaryPoint;
	import flaras.constants.*;
	import flaras.entity.*;
	import flaras.entity.object3D.*;
	import flaras.io.*;
	import flaras.io.fileReader.*;
	import flaras.marker.*;
	import flash.filesystem.*;
	import org.papervision3d.core.math.*;
	
	public class CtrPoint
	{
		private var _listOfPoints:Vector.<Point> = new Vector.<Point>();
		private var _listOfBoundaryPoints:Vector.<BoundaryPoint> = new Vector.<BoundaryPoint>();
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
			}			
		}
		
		private function destroyPointInfo(p:Point, removeFiles:Boolean):void
		{
			var facObj3D:FacadeObject3D;
			var bndPoint:BoundaryPoint;
			var obj3D:Object3D;
			var f:File;
			
			if (!removeFiles)
			{
				for each(obj3D in p.getListOfObjects())
				{
					facObj3D = new FacadeObject3D(obj3D);
					facObj3D.unLoad();
				}
			}
			else
			{
				for each(obj3D in p.getListOfObjects())
				{
					facObj3D = new FacadeObject3D(obj3D);
					facObj3D.unLoadAndRemoveFile(AudioDecorator.REMOVE_AUDIO_FILE);
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
			return new CtrListOfObjects(this._listOfPoints[indexPoint]);
		}
		
		// functions related with adding and removing points -----------------------------------------------------------
		public function addPointFromXML(pPosition:Number3D):void
		{
			var p:Point;
			
			p = new Point(this._listOfPoints.length, pPosition);
			this._listOfPoints.push(p);
			this._listOfBoundaryPoints.push(new BoundaryPoint(p.getPosition()));			
			
			//read the list of objects associated to the point p
			new FileReaderListOfObjects(p.getID(), FolderConstants.getFlarasAppCurrentFolder() + "/" + p.getFilePathListOfObjects(), this);
		}
		
		public function addPoint(pPosition:Number3D):void
		{
			var p:Point;
			
			p = new Point(this._listOfPoints.length, pPosition)
			this._listOfPoints.push(p);
			this._listOfBoundaryPoints.push(new BoundaryPoint(p.getPosition()));
		}
		
		public function removePoint(p:Point):void
		{
			var id:uint;
			
			id = p.getID()
			destroyPointInfo(p, true);
			
			//removing from the lists
			this._listOfPoints.splice(id, 1);
			this._listOfBoundaryPoints.splice(id, 1);		
			
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
				
			for each(var obj3D:Object3D in p.getListOfObjects())
			{
				facObj3D = new FacadeObject3D(obj3D);
				facObj3D.updateObject3DPosition();
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
			var listObjects:Vector.<Object3D>;
			
			if (p.isEnabled())
			{
				listObjects = p.getListOfObjects();
				indexActiveObject = p.getIndexActiveObject();
				var obj3D:Object3D = listObjects[indexActiveObject];
				obj3D.disableObject();
				
				p.setIndexActiveObject(indexActiveObject + pDirection)
				indexActiveObject = p.getIndexActiveObject();
				
				if (indexActiveObject > listObjects.length - 1)
				{
					p.setIndexActiveObject(0);
				}
				else
				{
					if (indexActiveObject < 0)
					{
						p.setIndexActiveObject(listObjects.length - 1);
					}
				}
				obj3D = listObjects[p.getIndexActiveObject()];
				obj3D.enableObject(true);				
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
			
			listObjects = p.getListOfObjects();
			var obj3D:Object3D = listObjects[p.getIndexActiveObject()];
			
			obj3D.disableObject();
			
			obj3D = listObjects[pObjectIndex];
			
			p.setIndexActiveObject(pObjectIndex);
			obj3D.enableObject(true);	
		}
		//end of functions related with navigating through the list of objects -------------------------------------------------------------
		
		// functions related with enabling and disabling points
		private function enablePoint(p:Point, pPlayAudio:Boolean, pPlaySystemAudio:Boolean):void
		{			
			var obj3D:Object3D;
			var listObjects:Vector.<Object3D>;
			var bndPoint:BoundaryPoint;
			
			bndPoint = _listOfBoundaryPoints[p.getID()];
			bndPoint.hidePointSphere();
			
			p.setEnabled(true);
			
			if (pPlaySystemAudio)
			{
				AudioManager.playSystemAudio(SystemFilesPathsConstants.AUDIO_PATH_ENABLE);
			}			
			
			listObjects = p.getListOfObjects();
			if (listObjects.length > 0)
			{
				p.setIndexActiveObject(p.getIndexLastActiveObject());
				obj3D = listObjects[p.getIndexActiveObject()];
			
				obj3D.enableObject(pPlayAudio);
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
				//p.enablePointSphere();
				bndPoint.showPointSphere();
			}
			
			bndPoint.hideAuxSphere();
			
			p.setEnabled(false);
			
			if (pPlayAudio)
			{
				AudioManager.playSystemAudio(SystemFilesPathsConstants.AUDIO_PATH_DISABLE);
			}
			
			listObjects = p.getListOfObjects();
			if (listObjects.length > 0)
			{
				p.setIndexLastActiveObject(p.getIndexActiveObject());
				
				obj3D = listObjects[p.getIndexActiveObject()];
				if (obj3D.isEnabled())
				{
					obj3D.disableObject();			
				}				
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