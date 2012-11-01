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
	import flaras.controller.audio.*;
	import flaras.controller.constants.*;
	import flaras.controller.io.fileReader.*;
	import flaras.model.marker.*;
	import flaras.view.marker.*;
	import flash.filesystem.*;
	import org.papervision3d.core.math.*;
	
	public class CtrMarker
	{
		private var _ctrMain:CtrMain;
		private var _viewRefMarker:ViewRefMarker;
		private var _viewInteractionMarker:ViewInteractionMarker;
		
		private var _modelInteractionMarker:ModelInteractionMarker;
		private var _modelRefMarker:ModelRefMarker;
		
		public static const DEFAULT_SPHERE_SIZE:uint = 20;
		public static const DEFAULT_SPHERE_DISTANCE:uint = 140;
		public static const DEFAULT_RADIUS_DIFFERENCE:uint = 10;
		
		public static const CONTROL_FORWARD:int = 1;
		public static const CONTROL_BACKWARD:int = -1;
		public static const CONTROL_MARKER:int = 0;
		public static const INSPECTOR_MARKER:int = 1;
		
		public static const REFERENCE_MARKER:uint = 0;
		public static const INTERACTION_MARKER:uint = 1;
		
		public static const REF_BASE_RECTANGLE_PLANE:uint = 0;
		public static const REF_BASE_POINT:uint = 1;
		
		public function CtrMarker(ctrMain:CtrMain)
		{
			this._ctrMain = ctrMain;
			
			this._modelRefMarker = new ModelRefMarker(REF_BASE_RECTANGLE_PLANE, false);
			this._viewRefMarker = new ViewRefMarker();
			_viewRefMarker.updateView(_modelRefMarker);
			
			this._modelInteractionMarker = new ModelInteractionMarker(DEFAULT_SPHERE_SIZE, DEFAULT_SPHERE_DISTANCE,
				INSPECTOR_MARKER, CONTROL_FORWARD);
			this._viewInteractionMarker = new ViewInteractionMarker(_modelInteractionMarker);
		}
		
		public function getModelInteractionMarker():ModelInteractionMarker
		{
			return _modelInteractionMarker;
		}
		
		public function getModelRefMarker():ModelRefMarker
		{
			return _modelRefMarker;
		}
		
		public function getWorldMatrixInteractionMarker():Matrix3D
		{
			return _viewInteractionMarker.getWorldMatrixObj3DSphere();
		}
		
		public function resetBaseType():void
		{
			_modelRefMarker.setBaseType(REF_BASE_RECTANGLE_PLANE);
			_viewRefMarker.updateView(_modelRefMarker);
		}
		
		public function resetInteractionMarkerSphereProperties():void
		{
			_modelInteractionMarker.setSphereSize(DEFAULT_SPHERE_SIZE);
			_modelInteractionMarker.setSphereDistance(DEFAULT_SPHERE_DISTANCE);
			
			this._viewInteractionMarker.updateDistance();
			this._viewInteractionMarker.updateSize();
		}
		
		public function changeRefMarkerBaseType(pBaseType:uint):void
		{
			_ctrMain.ctrUserProject.setUnsavedModifications(true);
			
			_modelRefMarker.setBaseType(pBaseType);
			_viewRefMarker.updateView(_modelRefMarker);
		}
		
		public function setMarkerType2Inspection():void
		{
			AudioManager.playSystemAudio(SystemFilesPathsConstants.AUDIO_PATH_INSPECTOR_MARKER);
			
			_modelInteractionMarker.setMarkerType(CtrMarker.INSPECTOR_MARKER);
			_viewInteractionMarker.change2InspectorMarker();
		}
		
		public function setMarkerType2ControlBackward():void
		{
			AudioManager.playSystemAudio(SystemFilesPathsConstants.AUDIO_PATH_CONTROL_BACKWARD_MARKER);
			
			_modelInteractionMarker.setMarkerType(CtrMarker.CONTROL_MARKER);
			_modelInteractionMarker.setControlMarkerType(CtrMarker.CONTROL_BACKWARD);
			_viewInteractionMarker.change2ControlMarkerBackward();
		}
		
		public function setMarkerType2ControlForward():void
		{
			AudioManager.playSystemAudio(SystemFilesPathsConstants.AUDIO_PATH_CONTROL_FORWARD_MARKER);
			
			_modelInteractionMarker.setMarkerType(CtrMarker.CONTROL_MARKER);
			_modelInteractionMarker.setControlMarkerType(CtrMarker.CONTROL_FORWARD);
			_viewInteractionMarker.change2ControlMarkerForward();
		}
		
		public function updateInteractionSphereSize(size:int):void
		{
			_ctrMain.ctrUserProject.setUnsavedModifications(true);
			_modelInteractionMarker.setSphereSize(size);
			_viewInteractionMarker.updateSize();
		}
		
		public function updateInteractionSphereDistance(distance:int):void
		{
			_ctrMain.ctrUserProject.setUnsavedModifications(true);
			_modelInteractionMarker.setSphereDistance(distance);
			_viewInteractionMarker.updateDistance();
		}
		
		public function setInteractionSphereData(distance:uint, size:uint):void
		{
			_modelInteractionMarker.setSphereDistance(distance);
			_modelInteractionMarker.setSphereSize(size);
			
			_viewInteractionMarker.updateDistance();
			_viewInteractionMarker.updateSize();
			_ctrMain.ctrGUI.getInteractionGUI().getViewWindowInteractionSphere().setSliderDistance(distance);
			_ctrMain.ctrGUI.getInteractionGUI().getViewWindowInteractionSphere().setSliderSize(size);
		}
		
		public function loadInteractionMarkerData():void
		{
			new FileReaderInteractionSphere(this, FolderConstants.getFlarasAppCurrentFolder() + "/" + XMLFilesConstants.INTERACTION_SPHERE_PATH);
		}
		
		public function loadRefMarkerData():void
		{
			new FileReaderRefMarker(this, FolderConstants.getFlarasAppCurrentFolder() + "/" + XMLFilesConstants.REF_MARKER_PROPERTIES_PATH);
		}
		
		public function finishedLoadingRefMarkerData(pRefMarkerBaseType:uint):void
		{
			_modelRefMarker.setBaseType(pRefMarkerBaseType);
			_viewRefMarker.updateView(_modelRefMarker);
			_ctrMain.ctrGUI.getGUI().getMarkerPanel().setJRBMarkerBaseType(_modelRefMarker.getBaseType());
		}
		
		public function toggleRefMarkerPersistence():void
		{
			if (_modelRefMarker.getPersistence())
			{
				_modelRefMarker.setPersistence(false);
			}
			else
			{
				_modelRefMarker.setPersistence(true);
			}
		}
		
		public function mirrorInteractionMarker():void
		{
			_viewInteractionMarker.mirror();
		}
		
		public function getInteractionSphereSize():int
		{
			return _modelInteractionMarker.getSphereSize();
		}
		
		public function getInteractionSphereDistance():int
		{
			return _modelInteractionMarker.getSphereDistance();
		}
	}
}