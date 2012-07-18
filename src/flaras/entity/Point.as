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

package flaras.entity
{
	import flaras.*;
	import flaras.audio.*;
	import flaras.constants.*;
	import flaras.controller.*;
	import flaras.entity.object3D.*;
	import flaras.errorHandler.*;
	import flaras.io.*;
	import flaras.marker.*;
	import flaras.util.*;
	import flash.events.*;
	import flash.filesystem.*;
	import org.papervision3d.core.math.*;
	import org.papervision3d.objects.*;
	import org.papervision3d.objects.parsers.*;
	import org.papervision3d.objects.primitives.*;
	
	public class Point
	{
		public static const RADIUS_SPHERE_OF_POINT:uint = 10;
		
		private var aID:uint;
		private var aEnabled:Boolean;
		private var aPosition:Number3D;
		
		//the axis is shown when the point is selected for edition on FLARAS Developer
		private var aAxisDAE:DAE;
		private var aObj3DSphereOfPoint:DisplayObject3D;
		private var aObj3DAuxSphere:DisplayObject3D;
		private var aIndexActiveObject:int = 0;
		private var aIndexLastActiveObject:int = 0;
		private var aInteractionLock:Boolean = false;
		private var ctrListOfObjects:CtrListOfObjects;
		
		public function Point(pID:uint, pPosition:Number3D, pObjCtrObjects:CtrPoint)
		{			
			ctrListOfObjects = new CtrListOfObjects(this);
			aID = pID;
			aEnabled = false;
			aPosition = pPosition;
			
			aObj3DSphereOfPoint = new Sphere(Color.gray, RADIUS_SPHERE_OF_POINT, 10, 10);
			aObj3DSphereOfPoint.position = aPosition;
			
			aObj3DAuxSphere = new Sphere(Color.blue, RADIUS_SPHERE_OF_POINT, 10, 10);
			aObj3DAuxSphere.position = aPosition;
			aObj3DAuxSphere.visible = false;
			
			aAxisDAE = new DAE();
			aAxisDAE.load(SystemFilesPathsConstants.OBJ_PATH_AXIS);
			aAxisDAE.addEventListener(IOErrorEvent.IO_ERROR, ErrorHandler.onIOErrorAsynchronous);
			aAxisDAE.addEventListener(SecurityErrorEvent.SECURITY_ERROR, ErrorHandler.onSecurityErrorAsynchronous)
			aAxisDAE.scale = 10;
			aAxisDAE.position = aPosition;
			aAxisDAE.visible = false;
			
			MarkerNodeManager.addObj2MarkerNode(aObj3DAuxSphere, Marker.REFERENCE_MARKER , null);
			MarkerNodeManager.addObj2MarkerNode(aObj3DSphereOfPoint, Marker.REFERENCE_MARKER, null);
			MarkerNodeManager.addObj2MarkerNode(aAxisDAE, Marker.REFERENCE_MARKER, null);
		}
		
		public function getCtrListOfObjects():CtrListOfObjects
		{
			return ctrListOfObjects;
		}
		
		public function getIndexActiveObject():int
		{
			return aIndexActiveObject;
		}
		
		public function setIndexActiveObject(pIndex:int):void
		{
			aIndexActiveObject = pIndex;
		}
		
		public function getIndexLastActiveObject():int
		{
			return aIndexLastActiveObject;
		}
		
		public function setIndexLastActiveObject(pIndex:int):void
		{
			aIndexLastActiveObject = pIndex;
		}
		
		public function getInteractionLock():Boolean
		{
			return aInteractionLock;
		}
		
		public function setInteractionLock(pInteractionLock:Boolean):void
		{
			aInteractionLock = pInteractionLock;
		}
		
		public function getID():uint
		{
			return aID;
		}
		
		public function setID(pID:uint):void
		{
			aID = pID;
		}
		
		public function isEnabled():Boolean
		{
			return aEnabled;
		}
		
		public function setEnabled(enable:Boolean):void
		{
			aEnabled = enable;
		}
		
		public function isObj3DAuxSphereVisible():Boolean
		{
			return aObj3DAuxSphere.visible;
		}
		
		public function getPosition():Number3D
		{
			return aPosition;
		}
		
		public function getFilePathListOfObjects():String
		{
			return XMLFilesConstants.LIST_OF_OBJECTS_SEMI_COMPLETE_PATH + getID() + ".xml";
		}
		
		public function getListOfObjects():Vector.<Object3D>
		{
			return ctrListOfObjects.getListOfObjects();
		}
		
		public function setPosition(pPosition:Number3D):void
		{
			var facObj3D:FacadeObject3D;
			
			aPosition = pPosition;
			
			aObj3DSphereOfPoint.position = pPosition;
			aObj3DAuxSphere.position = pPosition;
			aAxisDAE.position = pPosition;
			
			for each(var obj3D:Object3D in ctrListOfObjects.getListOfObjects())
			{
				facObj3D = new FacadeObject3D(obj3D);
				facObj3D.updateObject3DPosition();
			}
		}

		public function changeVisibleAuxSphere():void
		{
			if (aObj3DAuxSphere.visible)
			{
				aObj3DAuxSphere.visible = false;
			}
			else
			{
				aObj3DAuxSphere.visible = true;
			}
		}
		
		public function enablePointSphere():void
		{
			aObj3DSphereOfPoint.visible = true;
		}
		
		public function disablePointSphere():void
		{
			aObj3DSphereOfPoint.visible = false;
		}
		
		public function enableAxis():void
		{
			aAxisDAE.visible = true;
		}
		
		public function disableAxis():void
		{
			aAxisDAE.visible = false;
		}
		
		public function isAxisEnabled():Boolean
		{
			return aAxisDAE.visible;
		}
		
		public function disableAuxSphere():void
		{
			aObj3DAuxSphere.visible = false;
		}
		
		//unLoad all the objects associated to the point and also the point's position sphere
		public function unLoad():void
		{
			var facObj3D:FacadeObject3D;
			
			for each(var obj3D:Object3D in ctrListOfObjects.getListOfObjects())
			{
				facObj3D = new FacadeObject3D(obj3D);
				facObj3D.unLoad();
			}
			
			unLoadSpheresPoint();
		}
		
		private function unLoadSpheresPoint():void
		{
			MarkerNodeManager.removeObjFromMarkerNode(aObj3DAuxSphere, Marker.REFERENCE_MARKER);
			MarkerNodeManager.removeObjFromMarkerNode(aObj3DSphereOfPoint, Marker.REFERENCE_MARKER);
			MarkerNodeManager.removeObjFromMarkerNode(aAxisDAE, Marker.REFERENCE_MARKER);
		}
		
		public function unLoadAndRemoveFile():void
		{
			var facObj3D:FacadeObject3D;
			var f:File;
			for each(var obj3D:Object3D in ctrListOfObjects.getListOfObjects())
			{
				facObj3D = new FacadeObject3D(obj3D);
				facObj3D.unLoadAndRemoveFile(AudioDecorator.REMOVE_AUDIO_FILE);
			}
			
			unLoadSpheresPoint();
			
			//removing the xml file with the object list
			f = new File(FolderConstants.getFlarasAppCurrentFolder() + "/" + getFilePathListOfObjects());
			
			if (f.exists)
			{
				FileRemover.remove(f.nativePath);
			}
		}
	}	
}