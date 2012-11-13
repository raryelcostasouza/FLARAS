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

package flaras.model.marker
{
	import flaras.controller.*;
	import org.papervision3d.core.math.*;
	
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