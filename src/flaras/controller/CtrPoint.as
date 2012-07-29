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
		private var _ctrMain:CtrMain;
		
		public function CtrPoint(ctrMain:CtrMain)
		{
			this._ctrMain = ctrMain;
		}
		
		public function loadProjectData():void
		{			
			new FileReaderListOfPoints(FolderConstants.getFlarasAppCurrentFolder() + "/" + XMLFilesConstants.LIST_OF_POINTS_PATH, this);
		}
		
		public function finishedReadingListOfPoints():void
		{
			this._ctrMain.ctrGUI.comboBoxReload();
		}
		
		public function clearListOfPoints():void
		{
			if (this._listOfPoints.length != 0)
			{
				for each(var p:Point in this._listOfPoints)
				{
					p.unLoad();
				}
				this._listOfPoints = new Vector.<Point>();
			}			
		}
		
		public function getListOfPoints():Vector.<Point>
		{
			return this._listOfPoints;
		}
		
		// functions related with adding and removing points -----------------------------------------------------------
		public function addPointFromXML(pPosition:Number3D):void
		{
			var p:Point;
			
			p = new Point(this._listOfPoints.length, pPosition);
			this._listOfPoints.push(p);
			//read the list of objects associated to the point p
			new FileReaderListOfObjects(p.getID(), FolderConstants.getFlarasAppCurrentFolder() + "/" + p.getFilePathListOfObjects(), this);
		}
		
		public function addPoint(pPosition:Number3D):void
		{
			this._listOfPoints.push(new Point(this._listOfPoints.length, pPosition));
		}
		
		public function removePoint(pPointID:uint):void
		{
			var id:uint;
			
			this._listOfPoints[pPointID].unLoadAndRemoveFile();
			this._listOfPoints.splice(pPointID, 1);
			
			id = 0;
			for each(var p:Point in this._listOfPoints)
			{
				p.setID(id);
				id++;
			}
		}
		// end of functions related with adding and removing points -----------------------------------------------------------
		
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
		public function enablePoint(p:Point, pPlayAudio:Boolean, pPlaySystemAudio:Boolean):void
		{			
			var obj3D:Object3D;
			var listObjects:Vector.<Object3D>;
			
			p.disablePointSphere();
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
		
		public function disablePoint(p:Point, pPlayAudio:Boolean):void
		{
			var obj3D:Object3D;
			var listObjects:Vector.<Object3D>;				

			if (!p.isAxisEnabled())
			{
				p.enablePointSphere();
			}
			
			p.disableAuxSphere();
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
			
			enablePoint(p, true, false);
			p.enableAxis();
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
			for each(var p:Point in this._listOfPoints)
			{
				p.disableAxis();				
				disablePoint(p, pPlayAudio);
			}
		}
		//end of functions related with enabling and disabling points
		
		public function changeVisibleAuxSphereOfPoints():void
		{
			for each(var p:Point in this._listOfPoints)
			{
				if (p.isEnabled())
				{
					p.changeVisibleAuxSphere();
				}				
			}
		}
		//end of functions related with navigating through the list of objects -------------------------------------------------------------
		
		
		//functions related with the list of objects --------------------------------------------------------------------------------------		
		public function getCtrListOfObjects(indexPoint:uint):CtrListOfObjects
		{
			//return this._listOfPoints[indexPoint].getCtrListOfObjects();
			return new CtrListOfObjects(this._listOfPoints[indexPoint]);
		}
		//end of functions relaterd with the list of objects --------------------------------------------------------------------------------------
	}		
}