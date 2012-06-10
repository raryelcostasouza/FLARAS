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
	import flash.media.*;
	
	public class CtrCamera 
	{
		private var _ctrMain:CtrMain;
		private var _selectedCameraIndex:uint
		private var _cameraDisabled:Boolean;
		
		public function CtrCamera(ctrMain:CtrMain) 
		{
			this._ctrMain = ctrMain;
		}	
		
		public function setCameraStatus(cameraDisabled:Boolean):void
		{
			_cameraDisabled = cameraDisabled;
			if (cameraDisabled)
			{
				_ctrMain.fmmapp.stopCamera();
			}
			else
			{
				_ctrMain.fmmapp.startCamera();
			}
		}
		
		public function isCameraDisabled():Boolean
		{
			return this._cameraDisabled;
		}
		
		public function selectCameraToCapture():void
		{
			var vectorCameraNames:Vector.<String>;
			vectorCameraNames = new Vector.<String>();
			
			for each(var cameraName:String in Camera.names)
			{
				vectorCameraNames.push(cameraName);
			}
			
			_ctrMain.ctrGUI.getGUI().getCameraSelectWindow().openWindow(vectorCameraNames, _selectedCameraIndex);
		}
		
		public function cameraSelected(cameraIndex:uint):void
		{
			_selectedCameraIndex = cameraIndex;
			_ctrMain.fmmapp.selectCamera2Capture(cameraIndex);
		}
	}
}