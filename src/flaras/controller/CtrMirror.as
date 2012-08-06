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
	import FTK.*;

	public class CtrMirror 
	{
		public static var MIRRORED_SCALE_FACTOR:int = 1;
		
		private var _ctrMain:CtrMain;
		private var aFMMApp:FLARToolKitMultiMarkerApp;
		
		public function CtrMirror(ctrMain:CtrMain, pFMMApp:FLARToolKitMultiMarkerApp) 
		{
			this._ctrMain = ctrMain;
			aFMMApp = pFMMApp;
		}
		
		public function toggleMirror(actionfiredFromKeyboard:Boolean):void
		{			
			aFMMApp.changeScreenMirror();
			
			if (MIRRORED_SCALE_FACTOR == 1)
			{
				MIRRORED_SCALE_FACTOR = -1;
			}
			else
			{
				MIRRORED_SCALE_FACTOR = 1;
			}
			_ctrMain.ctrMarker.mirrorInteractionMarker();
			_ctrMain.ctrPoint.toggleMirrorPointsScenes();
			
			if (actionfiredFromKeyboard)
			{
				if (MIRRORED_SCALE_FACTOR == 1)
				{
					_ctrMain.ctrGUI.getGUI().getMenu().setStatusJCBMirrorScreen(true);
				}
				else
				{
					_ctrMain.ctrGUI.getGUI().getMenu().setStatusJCBMirrorScreen(false);
				}				
			}
		}		
	}
}