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
	import flaras.io.fileReader.FileReaderInteractionSphere;
	import flaras.marker.*;
	
	public class CtrMarker 
	{		
		private var _ctrMain:CtrMain;
		private var _refMarker:Marker;
		private var _interactionMarker:InteractionMarker;
		
		public function CtrMarker(ctrMain:CtrMain) 
		{
			this._ctrMain = ctrMain;
			this._refMarker = new Marker();
			
			this._interactionMarker = new InteractionMarker();
		}
		
		public function get interactionMarker():InteractionMarker
		{
			return this._interactionMarker;
		}	
		
		public function get refMarker():Marker
		{
			return this._refMarker;
		}
		
		public function resetInteractionMarkerSphereProperties():void
		{
			this._interactionMarker.setSphereDistance(140);
			this._interactionMarker.setSphereSize(20);
		}
		
		public function changeMarkerType():void
		{
			// if the marker is inspector marker
			if (_interactionMarker.getMarkerType() == InteractionMarker.INSPECTOR_MARKER)
			{
				AudioManager.playSystemAudio(SystemFilesPathsConstants.AUDIO_PATH_CONTROL_MARKER);
				
				//change it to control marker
				_interactionMarker.change2ControlMarker();
			}
			// if the marker is the control marker
			else
			{
				AudioManager.playSystemAudio(SystemFilesPathsConstants.AUDIO_PATH_INSPECTOR_MARKER);
				
				//change it to inspector marker
				_interactionMarker.change2InspectorMarker();
			}
		}
		
		public function changeControlMarkerType():void
		{
			//only does something if the marker type is control marker
			if (_interactionMarker.getMarkerType() == InteractionMarker.CONTROL_MARKER)
			{
				// if it's forward control marker
				if (_interactionMarker.getControlMarkerType() == InteractionMarker.CONTROL_FORWARD)
				{	
					AudioManager.playSystemAudio(SystemFilesPathsConstants.AUDIO_PATH_CONTROL_BACKWARD_MARKER);
					//change it to backward control marker
					_interactionMarker.change2ControlMarkerBackward();
				}
				// if it's backward control marker
				else
				{
					AudioManager.playSystemAudio(SystemFilesPathsConstants.AUDIO_PATH_CONTROL_FORWARD_MARKER);
					//change it to forward control marker
					_interactionMarker.change2ControlMarkerForward();
				}
			}
		}
		
		public function changeInteractionSphereSize(deltaSize:int):void
		{
			var newSize:uint = _interactionMarker.getSphereSize() + deltaSize;
			
			if (newSize > 0)
			{
				_interactionMarker.setSphereSize(newSize);
			}			
		}
		
		public function changeInteractionSphereDistance(deltaDistance:int):void
		{
			var newDistance:uint = _interactionMarker.getSphereDistance() + deltaDistance;
			
			if (newDistance > 0)
			{
				_interactionMarker.setSphereDistance(newDistance);
			}	
		}	
		
		public function setInteractionSphereData(distance:uint, size:uint):void
		{
			_interactionMarker.setSphereDistance(distance);
			_interactionMarker.setSphereSize(size);
		}
		
		public function loadInteractionMarkerData():void
		{
			new FileReaderInteractionSphere(this, FolderConstants.getFlarasAppCurrentFolder() + "/"
													+ XMLFilesConstants.INTERACTION_SPHERE_PATH );
		}	
		
		public function finishedLoadingInteractionMarkerData(intSphereData:InteractionSphereData):void
		{
			_interactionMarker.setSphereSize(intSphereData.size);
			_interactionMarker.setSphereDistance(intSphereData.distance);
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
	}
}