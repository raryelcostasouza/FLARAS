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

package flaras.userInterface
{
	import flaras.controller.*;
	import flaras.userInterface.graphicUserInterfaceComponents.*;
	import flash.display.*;
	import flash.events.*;
	import org.aswing.*;
	import org.aswing.border.*;
	import org.aswing.geom.*;
	
	public class GraphicsUserInterface extends JFrame
	{
		//control variables
		private var aControl:CtrInteractionUI;
		private var aStage:Stage;
		private var ctrGui:CtrGUI;
		
		//graphical variables
		private var menuWindow:JWindow;
		private var menuPanel:JPanel;
		private var menu:Menu;
		
		private var window:JWindow;
		private var masterPanel:PropertiesPanel;
		private var object3DPanel:Object3DPopupPanel;
		private var videoPanel:ObjectVideoPopupPanel;
		private var texturePanel:ObjectTexturePopupPanel;
		
		public function GraphicsUserInterface(pControl:CtrInteractionUI, pStage:Stage)
		{
			aControl = pControl;
			aStage = pStage;
			ctrGui = new CtrGUI(aControl, this);
			
			pStage.scaleMode = StageScaleMode.NO_SCALE;
			pStage.stageFocusRect = false;
			AsWingManager.setRoot(aStage);
			initComponents();
			aStage.addEventListener(MouseEvent.CLICK, mouseClick);
			aStage.addEventListener(MouseEvent.MOUSE_WHEEL, mouseWheel);
		}
		
		public function getCtrGUI():CtrGUI
		{
			return ctrGui;
		}
		
		private function initComponents():void {
			var principal:JPanel = new JPanel(new BorderLayout());
			var auxiliar:JPanel = new JPanel();
			menu = new Menu(aControl, ctrGui);
			auxiliar.append(menu);
			principal.append(auxiliar, BorderLayout.WEST);
			masterPanel = new PropertiesPanel(aStage, ctrGui);
			masterPanel.setPreferredSize(new IntDimension(200, 470));
			principal.append(masterPanel, BorderLayout.EAST);
			principal.alpha = 0.75;
			
			//addiction of modules object3d, video and texture
			object3DPanel = new Object3DPopupPanel(aStage, ctrGui);
			videoPanel = new ObjectVideoPopupPanel(aStage, ctrGui);
			texturePanel = new ObjectTexturePopupPanel(aStage, ctrGui);
			ctrGui.setPropertiesPanel(masterPanel);
			ctrGui.setObject3Dpanel(object3DPanel);
			ctrGui.setObjectVideoPanel(videoPanel);
			ctrGui.setObjectTexturePanel(texturePanel);
			
			masterPanel.setBackgroundDecorator(new SolidBackground(UIManager.getColor("window")));
			masterPanel.setBorder(new LineBorder());
			
			window = new JWindow(aStage);
			window.setContentPane(principal);
			window.setSizeWH(640, 480);
			window.show();
			
			ctrGui.start();
		}
		
		private function mouseClick(e:MouseEvent):void {
			if (e.currentTarget == aStage) {
				window.visible = true;
			}
		}
		
		private function mouseWheel(e:MouseEvent):void {
			if (e.currentTarget == aStage) {
				window.visible = false;
			}
		}
	}
}
