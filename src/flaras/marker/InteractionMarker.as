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

package flaras.marker
{
	import flaras.*;
	import flaras.audio.*;
	import flaras.constants.*;
	import flaras.errorHandler.*;
	import flaras.io.*;
	import flaras.multiMarkerInteraction.*;
	import flaras.util.*;
	import flash.events.*;
	import flash.net.*;
	import org.papervision3d.core.math.*;
	import org.papervision3d.materials.*;
	import org.papervision3d.objects.*;
	import org.papervision3d.objects.primitives.*;
	
	public class InteractionMarker
	{
		private var aObj3DSphere:DisplayObject3D;
		private var aObj3DSphereUnlock:DisplayObject3D;
		private var aObj3DCoverInspector:DisplayObject3D;
		private var aObj3DCoverControlForward:DisplayObject3D;
		private var aObj3DCoverControlBackward:DisplayObject3D;
		// There are two interaction sphere objects in this class. 
		// The biggest sphere is the unlock interaction sphere.
		// The smallest sphere is the lock interaction sphere.
		// When the point is inside the LockInteraction Sphere the interaction happens and becomes locked
		// only when the point goes out the UnlockInteractionSphere that a new interaction in the point will be allowed (unlocked)
		private var aObjLockInteractionSphere:InteractionSphere;
		private var aObjUnlockInteractionSphere:InteractionSphere;
		private var aMarkerType:int;
		private var aControlMarkerType:int;
		
		public static const CONTROL_FORWARD:int = 1;
		public static const CONTROL_BACKWARD:int = -1;
		
		public static const CONTROL_MARKER:int = 0;
		public static const INSPECTOR_MARKER:int = 1;
		
		public function InteractionMarker()
		{			
			initDefaultCover();
			aMarkerType = INSPECTOR_MARKER;
			aControlMarkerType = CONTROL_FORWARD;
			aObjLockInteractionSphere = new InteractionSphere(new Number3D(0, 140, 0), 20);
			aObjUnlockInteractionSphere = new InteractionSphere(new Number3D(0, 140, 0), 30);
			build3DSphere();
			
			MarkerNodeManager.addObj2MarkerNode(aObj3DSphere, Marker.INTERACTION_MARKER, null);
			MarkerNodeManager.addObj2MarkerNode(aObj3DSphereUnlock, Marker.INTERACTION_MARKER, null);
		}
		
		public function getSphereSize():uint
		{
			return aObjLockInteractionSphere.getRadius();
		}
		
		public function getSphereDistance():uint
		{
			return aObj3DSphere.y;
		}
		
		public function getMarkerType():int
		{
			return aMarkerType;
		}
		
		public function getControlMarkerType():int
		{
			return aControlMarkerType;
		}
		
		public function getWorldMatrixObj3DSphere():Matrix3D
		{
			return aObj3DSphere.world;
		}
		
		public function getObjLockInteractionSphere():InteractionSphere
		{
			return aObjLockInteractionSphere;
		}
		
		public function getObjUnlockInteractionSphere():InteractionSphere
		{
			return aObjUnlockInteractionSphere;
		}
		
		public function setSphereSize(newSize:int):void
		{
			aObjLockInteractionSphere.setRadius(newSize);
			aObjUnlockInteractionSphere.setRadius(newSize+10);
			update3DSphere();
		}
		
		public function setSphereDistance(newDistance:int):void
		{
			aObjLockInteractionSphere.setY(newDistance);
			aObjUnlockInteractionSphere.setY(newDistance);
			
			aObj3DSphere.y = newDistance;
			aObj3DSphereUnlock.y = newDistance;			
		}
		
		private function initDefaultCover():void
		{			
			aObj3DCoverInspector = buildTextureCover(SystemFilesPathsConstants.TEXTURE_PATH_INSPECTOR_MARKER);
			aObj3DCoverControlForward = buildTextureCover(SystemFilesPathsConstants.TEXTURE_PATH_CONTROL_FORWARD_MARKER);
			aObj3DCoverControlBackward = buildTextureCover(SystemFilesPathsConstants.TEXTURE_PATH_CONTROL_BACKWARD_MARKER);
			
			aObj3DCoverControlForward.visible = false;
			aObj3DCoverControlBackward.visible = false;
			
			MarkerNodeManager.addObj2MarkerNode(aObj3DCoverInspector, Marker.INTERACTION_MARKER, null);
			MarkerNodeManager.addObj2MarkerNode(aObj3DCoverControlForward, Marker.INTERACTION_MARKER, null);
			MarkerNodeManager.addObj2MarkerNode(aObj3DCoverControlBackward, Marker.INTERACTION_MARKER, null);
		}
		
		private function buildTextureCover(pFilePath:String):DisplayObject3D
		{
			var obj3D:DisplayObject3D;
			
			var urlLoader:URLLoader = new URLLoader(new URLRequest(pFilePath));
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR, ErrorHandler.onIOErrorAsynchronous);
			urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, ErrorHandler.onSecurityErrorAsynchronous);
			urlLoader.addEventListener(Event.COMPLETE, GeneralIOEventHandler.onIOOperationComplete);
			
			obj3D = new Plane(new BitmapFileMaterial(pFilePath), 80, 80);
			obj3D.rotationX = -180;
			obj3D.position = new Number3D(0, 0, 0);
			
			return obj3D;
		}
		
		private function update3DSphere():void
		{
			MarkerNodeManager.removeObjFromMarkerNode(aObj3DSphere, Marker.INTERACTION_MARKER);
			MarkerNodeManager.removeObjFromMarkerNode(aObj3DSphereUnlock, Marker.INTERACTION_MARKER);
			build3DSphere();			
			MarkerNodeManager.addObj2MarkerNode(aObj3DSphere, Marker.INTERACTION_MARKER, null);
			MarkerNodeManager.addObj2MarkerNode(aObj3DSphereUnlock, Marker.INTERACTION_MARKER, null);
		}
		
		private function build3DSphere():void
		{			
			aObj3DSphere = new Sphere(Color.green, aObjLockInteractionSphere.getRadius(), 10, 10);
			aObj3DSphere.position = aObjUnlockInteractionSphere.getCenter();
			
			aObj3DSphereUnlock = new Sphere(new WireframeMaterial(0xffe600), aObjUnlockInteractionSphere.getRadius(), 10, 10);
			aObj3DSphereUnlock.position = aObjUnlockInteractionSphere.getCenter();
		}
		
		public function change2InspectorMarker():void
		{
			aMarkerType = INSPECTOR_MARKER;
			aObj3DCoverInspector.visible = true;
			aObj3DCoverControlBackward.visible = false;
			aObj3DCoverControlForward.visible = false;	
		}
		
		public function change2ControlMarker():void
		{
			if (aControlMarkerType == CONTROL_BACKWARD)
			{
				change2ControlMarkerBackward();
			}
			else
			{
				change2ControlMarkerForward();
			}
		}
		
		public function change2ControlMarkerBackward():void
		{
			aMarkerType = CONTROL_MARKER;
			aControlMarkerType = CONTROL_BACKWARD;
			aObj3DCoverInspector.visible = false;
			aObj3DCoverControlBackward.visible = true;
			aObj3DCoverControlForward.visible = false;
		}
		
		public function change2ControlMarkerForward():void
		{
			aMarkerType = CONTROL_MARKER;
			aControlMarkerType = CONTROL_FORWARD;
			aObj3DCoverInspector.visible = false;
			aObj3DCoverControlBackward.visible = false;
			aObj3DCoverControlForward.visible = true;
		}
	}	
}