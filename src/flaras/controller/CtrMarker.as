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
	import flaras.audio.*;
	import flaras.constants.*;
	import flaras.io.fileReader.*;
	import flaras.marker.*;
	import flaras.model.marker.*;
	import flaras.view.marker.*;
	import org.papervision3d.core.math.*;
	
	public class CtrMarker 
	{		
		private var _ctrMain:CtrMain;
		private var _refMarker:Marker;
		private var _interactionMarker:InteractionMarker;
		
		private var _modelInteractionMarker:ModelInteractionMarker;
		
		private static const DEFAULT_SPHERE_SIZE:uint = 20;
		private static const DEFAULT_SPHERE_DISTANCE:uint = 140;
		public static const DEFAULT_RADIUS_DIFFERENCE:uint = 10;
		
		public static const CONTROL_FORWARD:int = 1;
		public static const CONTROL_BACKWARD:int = -1;
		
		public static const CONTROL_MARKER:int = 0;
		public static const INSPECTOR_MARKER:int = 1;
		
		public function CtrMarker(ctrMain:CtrMain) 
		{
			this._ctrMain = ctrMain;
			this._refMarker = new Marker();
			
			this._modelInteractionMarker = new ModelInteractionMarker(DEFAULT_SPHERE_SIZE, DEFAULT_SPHERE_DISTANCE, INSPECTOR_MARKER, CONTROL_FORWARD);
			this._interactionMarker = new InteractionMarker(_modelInteractionMarker);			
		}		
		
		public function getModelInteractionMarker():ModelInteractionMarker
		{
			return _modelInteractionMarker;
		}
		
		public function getWorldMatrixInteractionMarker():Matrix3D
		{
			return _interactionMarker.getWorldMatrixObj3DSphere();
		}
		
		public function get refMarker():Marker
		{
			return this._refMarker;
		}
		
		public function resetInteractionMarkerSphereProperties():void
		{
			_modelInteractionMarker.setSphereSize(DEFAULT_SPHERE_SIZE);
			_modelInteractionMarker.setSphereDistance(DEFAULT_SPHERE_DISTANCE);
			
			this._interactionMarker.updateDistance();
			this._interactionMarker.updateSize();
		}
		
		public function changeMarkerType():void
		{
			// if the marker is inspector marker
			if (_modelInteractionMarker.getMarkerType() == CtrMarker.INSPECTOR_MARKER)
			{
				AudioManager.playSystemAudio(SystemFilesPathsConstants.AUDIO_PATH_CONTROL_MARKER);
				
				//change it to control marker
				_modelInteractionMarker.setMarkerType(CtrMarker.CONTROL_MARKER);
				if (_modelInteractionMarker.getControlMarkerType() == CtrMarker.CONTROL_BACKWARD)
				{
					_interactionMarker.change2ControlMarkerBackward();
				}
				else
				{
					_interactionMarker.change2ControlMarkerForward();
				}
			}
			// if the marker is the control marker
			else
			{
				AudioManager.playSystemAudio(SystemFilesPathsConstants.AUDIO_PATH_INSPECTOR_MARKER);
				
				//change it to inspector marker
				_modelInteractionMarker.setMarkerType(CtrMarker.INSPECTOR_MARKER);
				_interactionMarker.change2InspectorMarker();
				
			}
		}
		
		public function changeControlMarkerType():void
		{
			//only does something if the marker type is control marker
			if (_modelInteractionMarker.getMarkerType() == CtrMarker.CONTROL_MARKER)
			{
				// if it's forward control marker
				if (_modelInteractionMarker.getControlMarkerType() == CtrMarker.CONTROL_FORWARD)
				{	
					AudioManager.playSystemAudio(SystemFilesPathsConstants.AUDIO_PATH_CONTROL_BACKWARD_MARKER);
					//change it to backward control marker
					_modelInteractionMarker.setControlMarkerType(CtrMarker.CONTROL_BACKWARD);
					_interactionMarker.change2ControlMarkerBackward();
				}
				// if it's backward control marker
				else
				{
					AudioManager.playSystemAudio(SystemFilesPathsConstants.AUDIO_PATH_CONTROL_FORWARD_MARKER);
					//change it to forward control marker
					_modelInteractionMarker.setControlMarkerType(CtrMarker.CONTROL_FORWARD);
					_interactionMarker.change2ControlMarkerForward();
				}
			}
		}
		
		public function changeInteractionSphereSize(deltaSize:int):void
		{
			var newSize:uint = _modelInteractionMarker.getSphereSize() + deltaSize;
			
			if (newSize > 0)
			{
				_modelInteractionMarker.setSphereSize(newSize);
				_interactionMarker.updateSize();
			}			
		}
		
		public function changeInteractionSphereDistance(deltaDistance:int):void
		{
			var newDistance:uint = _modelInteractionMarker.getSphereDistance() + deltaDistance;
			
			if (newDistance > 0)
			{
				_modelInteractionMarker.setSphereDistance(newDistance);
				_interactionMarker.updateDistance();
			}	
		}	
		
		public function setInteractionSphereData(distance:uint, size:uint):void
		{
			_modelInteractionMarker.setSphereDistance(distance);
			_modelInteractionMarker.setSphereSize(size);
			
			_interactionMarker.updateDistance();
			_interactionMarker.updateSize();
		}
		
		public function loadInteractionMarkerData():void
		{
			new FileReaderInteractionSphere(this, FolderConstants.getFlarasAppCurrentFolder() + "/"
													+ XMLFilesConstants.INTERACTION_SPHERE_PATH );
		}	
		
		public function finishedLoadingInteractionMarkerData(intSphereData:InteractionSphereData):void
		{
			_interactionMarker.updateDistance();
			_interactionMarker.updateDistance();
		}
		
		public function toggleRefMarkerPersistence():void
		{
			if (_refMarker.persistence)
			{
				refMarker.persistence = false;
			}
			else
			{
				refMarker.persistence = true;
			}
			_ctrMain.ctrGUI.getGUI().getMenu().setStatusJCBRefMarkPersist(refMarker.persistence);
		}
		
		public function mirrorInteractionMarker():void
		{
			_interactionMarker.mirror();
		}
	}
}