package flaras.model.marker
{
	import flaras.controller.CtrMarker;
	import flaras.multiMarkerInteraction.InteractionSphere;
	import org.papervision3d.core.math.Number3D;
	public class ModelInteractionMarker
	{		
		private var _sphereSize:uint;
		private var _sphereDistance:uint;
		
		// There are two interaction sphere objects in this class. 
		// The biggest sphere is the unlock interaction sphere.
		// The smallest sphere is the lock interaction sphere.
		// When the point is inside the LockInteraction Sphere the interaction happens and becomes locked
		// only when the point goes out the UnlockInteractionSphere that a new interaction in the point will be allowed (unlocked)
		private var _modelInteractionSphereLock:InteractionSphere;
		private var _modelInteractionSphereUnlock:InteractionSphere;
		
		private var _markerType:int;
		private var _controlMarkerType:int;
		
		public function ModelInteractionMarker(pSphereSize:uint, pSphereDistance:uint, pMarkerType:int, pControlMarkerType:int)
		{
			_sphereSize = pSphereSize;
			_sphereDistance = pSphereDistance;
			
			_modelInteractionSphereLock = new InteractionSphere(new Number3D(0, pSphereDistance, 0), pSphereSize);
			_modelInteractionSphereUnlock = new InteractionSphere(new Number3D(0, pSphereDistance, 0), pSphereSize + CtrMarker.DEFAULT_RADIUS_DIFFERENCE);
			
			_markerType = pMarkerType;
			_controlMarkerType = pControlMarkerType;
		}
		
		public function getSphereSize():uint
		{
			return _sphereSize;
		}
		
		public function getSphereDistance():uint
		{
			return _sphereDistance;
		}
		
		public function getModelInteractionSphereLock():InteractionSphere
		{
			return _modelInteractionSphereLock;
		}
		
		public function getModelInteractionSphereUnlock():InteractionSphere
		{
			return _modelInteractionSphereUnlock;
		}
		
		public function getMarkerType():int
		{ 
			return _markerType;
		}
		
		public function getControlMarkerType():int
		{ 
			return _controlMarkerType;
		}
		
		public function setSphereSize(pSphereSize:uint):void
		{
			_sphereSize = pSphereSize;
			_modelInteractionSphereLock.setRadius(pSphereSize);
			_modelInteractionSphereUnlock.setRadius(pSphereSize + CtrMarker.DEFAULT_RADIUS_DIFFERENCE);
		}
		
		public function setSphereDistance(pSphereDistance:uint):void
		{
			_sphereDistance = pSphereDistance;
			_modelInteractionSphereLock.setY(pSphereDistance);
			_modelInteractionSphereUnlock.setY(pSphereDistance);
		}	
		
		public function setMarkerType(pMarkerType:int):void
		{
			_markerType = pMarkerType;
		}
		
		public function setControlMarkerType(pControlMarkerType:int):void
		{
			_controlMarkerType = pControlMarkerType;
		}
	}
}