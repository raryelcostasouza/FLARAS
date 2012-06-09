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
	import flaras.util.*;
	import flash.display.*;
	import flash.events.*;
	import org.aswing.*;
	import org.aswing.border.*;
	import org.aswing.geom.*;
	
	public class GraphicsUserInterface
	{
		//control variables
		private var aControl:CtrInteractionUI;
		private var aStage:Stage;
		private var ctrGui:CtrGUI;
		private var _cameraSelectWindow:CameraSelectWindow;
		
		public static const developmentPanelWidth:uint = 214;
		
		public function GraphicsUserInterface(pControl:CtrInteractionUI)
		{
			aControl = pControl;
			aStage = StageReference.getStage();
			ctrGui = new CtrGUI(aControl, this);
			
			aStage.scaleMode = StageScaleMode.NO_SCALE;
			aStage.stageFocusRect = true;
			
			AsWingManager.setRoot(aStage);
			
			initComponents(); 
			initWindows();
		}
		
		public function getCtrGUI():CtrGUI
		{
			return ctrGui;
		}
		
		private function initComponents():void
		{
			var tabbedPane:JTabbedPane;
			var menuPanel:JPanel;
			var menu:Menu;
			var flarasGUI:JPanel;
			var developmentPanel:PropertiesPanel;
			var animationPanel:AnimationPanel;
			var window:JWindow;
			var object3DPanel:Object3DPopupPanel;
			var videoPanel:ObjectVideoPopupPanel;
			var texturePanel:ObjectTexturePopupPanel;
		
			tabbedPane = new JTabbedPane();
			flarasGUI = new JPanel(new BorderLayout());
			
			menuPanel = new JPanel();
			menu = new Menu(aControl, ctrGui);
			menuPanel.append(menu);
			flarasGUI.append(menuPanel, BorderLayout.WEST);
			
			developmentPanel = new PropertiesPanel(ctrGui);
			developmentPanel.setBackgroundDecorator(new SolidBackground(UIManager.getColor("window")));
			
			tabbedPane.appendTab(developmentPanel, "Basic", null, "Basic scene development");
			
			animationPanel = new AnimationPanel(ctrGui);
			tabbedPane.appendTab(animationPanel, "Animation", null, "Animation effects to the scene");
		
			//adding modules object3d, video and texture
			object3DPanel = new Object3DPopupPanel(ctrGui);
			videoPanel = new ObjectVideoPopupPanel(ctrGui);
			texturePanel = new ObjectTexturePopupPanel(ctrGui);
			ctrGui.setPropertiesPanel(developmentPanel);
			ctrGui.setObject3Dpanel(object3DPanel);
			ctrGui.setObjectVideoPanel(videoPanel);
			ctrGui.setObjectTexturePanel(texturePanel);
			ctrGui.setAnimationPanel(animationPanel);
			
			flarasGUI.append(tabbedPane, BorderLayout.EAST);
			flarasGUI.alpha = 0.75;
			
			window = new JWindow();
			window.setContentPane(flarasGUI);
			window.setSizeWH(854, 480);
			window.show();
			
			ctrGui.start();
		}
		
		private function initWindows():void
		{
			_cameraSelectWindow = new CameraSelectWindow(aControl);
		}
		
		public function getCameraSelectWindow():CameraSelectWindow
		{
			return _cameraSelectWindow;
		}
	}
}
