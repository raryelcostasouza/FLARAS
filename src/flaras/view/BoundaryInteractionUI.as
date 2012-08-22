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

package flaras.view
{
	import flaras.*;
	import flaras.controller.*;
	import flaras.controller.util.*;
	import flash.display.*;
	import flash.events.*;
	import flash.ui.*;
	
	public class BoundaryInteractionUI
	{
		private var _ctrMain:CtrMain;
		
		public function BoundaryInteractionUI(ctrMain:CtrMain)
		{
			_ctrMain = ctrMain;
			StageReference.getStage().addEventListener(KeyboardEvent.KEY_DOWN, keyboardMonitor);
		}
		
		private function keyboardMonitor(ke:KeyboardEvent):void
		{
			if (ke.ctrlKey)
			{
				var index:uint;
				
				// key is 0-9
				if (ke.keyCode >= 48 && ke.keyCode <= 57)
				{
					if (ke.charCode == 48)
					{
						index = 9;
					}
					else
					{
						index = ke.keyCode - 48 - 1;
					}
					
					_ctrMain.ctrPointInterWithKbd.selectPoint(index);
				}
				else
				{
					switch (ke.keyCode)
					{
						case 65: //A
							_ctrMain.ctrPoint.enableAllPoints();
							break;
						case 67: //C
							_ctrMain.ctrMarker.changeControlMarkerType();
							break;
						case 81: //Q
							_ctrMain.ctrPoint.disableAllPoints(true);
							break;
						case 77: //M
							_ctrMain.ctrMarker.changeMarkerType();
							break;
						case 80: //P
							_ctrMain.ctrMarker.toggleRefMarkerPersistence();
							break;
					}
				}				
			}
			else
			{
				switch (ke.keyCode)
				{
					case Keyboard.F1: 
						_ctrMain.ctrPoint.toggleVisibleAuxSphereOfPoints();
						break;
					case Keyboard.F3: 
						_ctrMain.ctrMirror.toggleMirror(true);
						break;
					case Keyboard.F4: 
						_ctrMain.ctrMarker.changeInteractionSphereSize(-1);
						break;
					case Keyboard.F5: 
						_ctrMain.ctrMarker.changeInteractionSphereSize(+1);
						break;
					case Keyboard.F6: 
						_ctrMain.ctrMarker.changeInteractionSphereDistance(-1);
						break;
					case Keyboard.F7: 
						_ctrMain.ctrMarker.changeInteractionSphereDistance(+1);
						break
					case Keyboard.F8: 
						_ctrMain.ctrMarker.resetInteractionMarkerSphereProperties();
						break;
					case Keyboard.PAGE_DOWN: 
						_ctrMain.ctrPointInterWithKbd.controlForwardInteractionWithSelectedPoint();
						break;
					case Keyboard.PAGE_UP: 
						_ctrMain.ctrPointInterWithKbd.controlBackwardInteractionWithSelectedPoint();
						break;
					case Keyboard.END: 
						_ctrMain.ctrPointInterWithKbd.deselectAllPoints();
						break;
				}
			}
		}
	}
}