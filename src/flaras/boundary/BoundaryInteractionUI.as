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
	import flaras.controller.*;
	import flaras.util.*;
	import flash.display.*;
	import flash.events.*;
	import flash.ui.*;
	
	public class BoundaryInteractionUI
	{
		private var _ctrInteractionUI:CtrInteractionUI;
		
		public function BoundaryInteractionUI(pObjCtrInteractionUI:CtrInteractionUI )
		{
			this._ctrInteractionUI = pObjCtrInteractionUI;
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
					
					this._ctrInteractionUI.getCtrMain().ctrPointInterWithKbd.selectPoint(index);
				}
			}
			else
			{
				switch(ke.keyCode)
				{
					case 65: //A
						this._ctrInteractionUI.getCtrMain().ctrPoint.enableAllPoints();
						break;
					case 67: //C
						this._ctrInteractionUI.getCtrMain().ctrMarker.changeControlMarkerType();
						break;
					case 81: //Q
						this._ctrInteractionUI.getCtrMain().ctrPoint.disableAllPoints(true);
						break;
					case 77: //M
						this._ctrInteractionUI.getCtrMain().ctrMarker.changeMarkerType();
						break;
					case Keyboard.F1:
						this._ctrInteractionUI.getCtrMain().ctrPoint.changeVisibleAuxSphereOfPoints();
						break;
					case Keyboard.F3:
						this._ctrInteractionUI.getCtrMain().ctrMirror.toggleMirror(true);
						break;
					case Keyboard.F4:
						this._ctrInteractionUI.getCtrMain().ctrMarker.changeInteractionSphereSize(-1);
						break;
					case Keyboard.F5:
						this._ctrInteractionUI.getCtrMain().ctrMarker.changeInteractionSphereSize(+1);
						break;
					case Keyboard.F6:
						this._ctrInteractionUI.getCtrMain().ctrMarker.changeInteractionSphereDistance(-1);
						break;
					case Keyboard.F7:
						this._ctrInteractionUI.getCtrMain().ctrMarker.changeInteractionSphereDistance(+1);
						break
					case Keyboard.F8:
						this._ctrInteractionUI.getCtrMain().ctrMarker.resetInteractionMarkerSphereProperties();
						break;
					case Keyboard.PAGE_DOWN:
						this._ctrInteractionUI.getCtrMain().ctrPointInterWithKbd.controlForwardInteractionWithSelectedPoint();	
						break;
					case Keyboard.PAGE_UP:
						this._ctrInteractionUI.getCtrMain().ctrPointInterWithKbd.controlBackwardInteractionWithSelectedPoint();	
						break;
					case Keyboard.END:
						this._ctrInteractionUI.getCtrMain().ctrPointInterWithKbd.deselectAllPoints();
						break;
				}	
			}
		}
	}	
}