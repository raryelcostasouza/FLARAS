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

package flaras.boundary
{
	import flaras.*;
	import flaras.audio.*;
	import flaras.constants.*;
	import flaras.controller.*;
	import flaras.controller.audio.*;
	import flaras.entity.*;
	import flaras.marker.*;
	import flaras.model.marker.*;
	import flaras.model.point.*;
	import flaras.multiMarkerInteraction.*;
	import flaras.util.*;
	import flash.events.*;
	import flash.utils.*;
	import org.papervision3d.core.math.*;

	public class  BoundaryMultiMarkerInteraction extends MultiMarkerInteraction
	{
		private var _ctrMain:CtrMain;
		//private var aObjInteractionMarker:InteractionMarker;
		private var _modelInteractionMarker:ModelInteractionMarker;
		private var listOfPoints:Vector.<Point>;
		
		public function BoundaryMultiMarkerInteraction(ctrMain:CtrMain)
		{
			var timer:Timer;
			
			_ctrMain = ctrMain;
			_modelInteractionMarker = _ctrMain.ctrMarker.getModelInteractionMarker();
			//aObjInteractionMarker = _ctrMain.ctrMarker.interactionMarker;
			
			timer = new Timer(20);
			timer.addEventListener(TimerEvent.TIMER, loopCheckInteractionAreas);
			timer.start();
		}

		private function loopCheckInteractionAreas(e:Event):void
		{
			var convertedPositionInteractionMarker:Number3D;
			listOfPoints = _ctrMain.ctrPoint.getListOfPoints();
				
			//if the FTK marker and Hiro marker are visible
			if (MarkerNodeManager.isMarkerDetected(Marker.INTERACTION_MARKER) && MarkerNodeManager.isMarkerDetected(Marker.REFERENCE_MARKER))
			{	
				for each(var p:Point in listOfPoints)
				{
					//conversion from the position of the interaction sphere of the interaction marker 
					//to the coordinates of the reference marker
					convertedPositionInteractionMarker = convertCoordPointToCoordMarker2(Marker.INTERACTION_MARKER, Marker.REFERENCE_MARKER, _ctrMain.ctrMarker.getWorldMatrixInteractionMarker());
					
					//if the point's interaction is not locked
					if (!p.getInteractionLock())
					{
						actionUnLockedInteraction(p, convertedPositionInteractionMarker);
					}
					else
					{
						actionLockedInteraction(p, convertedPositionInteractionMarker);
					}					
				}				
			}
		}
		
		// action that is done when the point's interaction is locked
		private function actionLockedInteraction(p:Point, pConvertedPositionInteractionMarker:Number3D):void
		{
			var convertedInteractionSphere:InteractionSphere;
			
			convertedInteractionSphere = new InteractionSphere(pConvertedPositionInteractionMarker, 
																			_modelInteractionMarker.getModelInteractionSphereUnlock().getRadius());

			// if the point is outside the most external sphere (unlock sphere of the interaction marker) then a new interaction 
			// will be allowed (unlocked)
			if (!happenedSphereCollision(p.getPosition(), convertedInteractionSphere))
			{
				p.setInteractionLock(false);
				AudioManager.playSystemAudio(SystemFilesPathsConstants.AUDIO_PATH_INTERACTION_POINT_UNLOCK);
			}
		}
		
		// action that is done when the point's interaction is unlocked
		private function actionUnLockedInteraction(p:Point, pConvertedPositionInteractionMarker:Number3D):void
		{
			var convertedInteractionSphere:InteractionSphere;
			
			convertedInteractionSphere = new InteractionSphere(pConvertedPositionInteractionMarker, 
																			_modelInteractionMarker.getModelInteractionSphereLock().getRadius());
					
			// if the point is inside the most internal sphere (lock sphere of the interaction marker) then a interaction will
			// be done and becomes locked
			if (happenedSphereCollision(p.getPosition(), convertedInteractionSphere))
			{	
				
				if (_modelInteractionMarker.getMarkerType() == CtrMarker.INSPECTOR_MARKER)
				{
					p.setInteractionLock(true);
					_ctrMain.ctrPoint.inspectPoint(p);
				}
				else
				{
					if (p.isEnabled())
					{
						p.setInteractionLock(true);
						_ctrMain.ctrPoint.controlPoint(p, _modelInteractionMarker.getControlMarkerType());
					}					
				}
			}
		}
	}	
}