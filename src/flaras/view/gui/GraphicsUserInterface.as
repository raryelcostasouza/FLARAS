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

package flaras.view.gui
{
	import flaras.controller.*;
	import flaras.controller.util.*;
	import flash.display.*;
	import flash.events.*;
	import org.aswing.*;
	import org.aswing.border.*;
	import org.aswing.geom.*;
	
	public class GraphicsUserInterface
	{
		//control variables
		private var _ctrMain:CtrMain;
		private var aStage:Stage;
		private var ctrGui:CtrGUI;
		private var _cameraSelectWindow:CameraSelectWindow;
		private var _swapWindow:SwapWindow;
		private var menu:Menu;
		
		private var _propertiesPanel:PropertiesPanel;
		private var _obj3DPanel:Object3DPopupPanel;
		private var _texturePanel:ObjectTexturePopupPanel;
		private var _videoPanel:ObjectVideoPopupPanel;
		private var _animationPanel:AnimationPanel;
		
		public static const developmentPanelWidth:uint = 214;
		
		public function GraphicsUserInterface(ctrMain:CtrMain, pCtrGUI:CtrGUI)
		{
			_ctrMain = ctrMain;
			aStage = StageReference.getStage();
			ctrGui = pCtrGUI;
			
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
			var window:JWindow;
			var window2:JWindow;
		
			tabbedPane = new JTabbedPane();
			
			menuPanel = new JPanel();
			menu = new Menu(_ctrMain);
			menuPanel.append(menu);
			
			_propertiesPanel = new PropertiesPanel(ctrGui);
			_propertiesPanel.setBackgroundDecorator(new SolidBackground(UIManager.getColor("window")));
			
			tabbedPane.appendTab(_propertiesPanel, "Basic", null, "Basic scene development");
			
			_animationPanel = new AnimationPanel(ctrGui);
			tabbedPane.appendTab(_animationPanel, "Animation", null, "Animation effects to the scene");
		
			//adding modules object3d, video and texture
			_obj3DPanel = new Object3DPopupPanel(ctrGui);
			_videoPanel = new ObjectVideoPopupPanel(ctrGui);
			_texturePanel = new ObjectTexturePopupPanel(ctrGui);
		
			window = new JWindow();
			window.setContentPane(menuPanel);
			window.pack();
			window.show();
			
			window2 = new JWindow();
			window2.setContentPane(tabbedPane);
			window2.setSizeWH(214, 480);
			window2.setLocationXY(640, 0);
			window2.show();
			window2.alpha = 0.75;
		}
		
		private function initWindows():void
		{
			_cameraSelectWindow = new CameraSelectWindow(_ctrMain);
			_swapWindow = new SwapWindow(ctrGui);
			MessageWindow.setParentComponent(_propertiesPanel);			
		}
		
		public function getCameraSelectWindow():CameraSelectWindow
		{
			return _cameraSelectWindow;
		}
		
		public function getSwapWindow():SwapWindow
		{
			return _swapWindow;
		}
		
		public function getMenu():Menu
		{
			return menu;
		}
		
		public function getPropertiesPanel():PropertiesPanel
		{
			return _propertiesPanel;
		}
		
		public function getObj3DPanel():Object3DPopupPanel
		{
			return _obj3DPanel;
		}
		
		public function getTexturePanel():ObjectTexturePopupPanel
		{
			return _texturePanel;
		}
		
		public function getVideoPanel():ObjectVideoPopupPanel
		{
			return _videoPanel;
		}
		
		public function getAnimationPanel():AnimationPanel
		{
			return _animationPanel;
		}	
	}
}
