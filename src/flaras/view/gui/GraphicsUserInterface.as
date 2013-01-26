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
		private var _ctrMain:CtrMain;
		private var ctrGui:CtrGUI;
		
		private var _cameraSelectWindow:CameraSelectWindow;
		private var _swapWindow:SwapWindow;
		private var menu:Menu;
		
		private var _projectTreePanel:ViewGUIProjectTree;
		private var _markerPanel:ViewGUIMarkerPanel;
		private var _pointPanel:ViewGUIPointPanel;
		private var _scenePanel:ViewGUIScenePanel;
		private var _developmentWindow:JWindow;
		private var _developmentPanel:JPanel;
		
		public function GraphicsUserInterface(ctrMain:CtrMain, pCtrGUI:CtrGUI)
		{
			_ctrMain = ctrMain;
			ctrGui = pCtrGUI;
			
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
			var window1:JWindow;
			var window2:JWindow;
		
			tabbedPane = new JTabbedPane();
			
			menuPanel = new JPanel();
			menu = new Menu(_ctrMain);
			menuPanel.append(menu);
		
			window1 = new JWindow();
			window1.setContentPane(menuPanel);
			window1.pack();
			window1.show();
			
			_projectTreePanel = new ViewGUIProjectTree(ctrGui, this);
			_markerPanel = new ViewGUIMarkerPanel(ctrGui);
			_pointPanel = new ViewGUIAttractRepulsionPointPanel(ctrGui, _projectTreePanel.getJTree());
			_scenePanel = new ViewGUIScenePanel(ctrGui);			
			
			_developmentWindow = new JWindow();
			_developmentWindow.setSizeWH(214, 540);
			_developmentWindow.setLocationXY(640, 0);
			_developmentWindow.setContentPane(buildDevelopmentPanel());
			_developmentWindow.show();
		}
		
		public function buildDevelopmentPanel():JPanel
		{
			var projectTreePanel:JPanel;
			
			_developmentPanel = new JPanel(new GridLayout(2, 1));
			_developmentPanel.append(_projectTreePanel);
			_developmentPanel.append(_markerPanel);
			
			return _developmentPanel;
		}
		
		public function showMarkerPanel():void
		{
			if (_developmentPanel.remove(_pointPanel) || _developmentPanel.remove(_scenePanel))
			{
				_developmentPanel.append(_markerPanel);
				_markerPanel.setSelectedIndex(0);
				_developmentPanel.revalidateIfNecessary();
			}
		}
		
		public function showPointPanel():void
		{
			if (_developmentPanel.remove(_markerPanel) || _developmentPanel.remove(_scenePanel))
			{
				_developmentPanel.append(_pointPanel);
				_pointPanel.setSelectedIndex(0);
				_developmentPanel.revalidateIfNecessary();
			}
		}
		
		public function showScenePanel():void
		{
			if (_developmentPanel.remove(_pointPanel) || _developmentPanel.remove(_markerPanel))
			{
				_developmentPanel.append(_scenePanel);
				_scenePanel.setSelectedIndex(0);
				_developmentPanel.revalidateIfNecessary();
			}
		}
		
		private function initWindows():void
		{
			_cameraSelectWindow = new CameraSelectWindow(_ctrMain);
			_swapWindow = new SwapWindow(ctrGui);
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
		
		public function getTreePanel():ViewGUIProjectTree
		{
			return _projectTreePanel;
		}
		
		public function getPointPanel():ViewGUIPointPanel
		{
			return _pointPanel;
		}
		
		public function getScenePanel():ViewGUIScenePanel 
		{
			return _scenePanel;
		}
		
		public function getMarkerPanel():ViewGUIMarkerPanel 
		{
			return _markerPanel;
		}
	}
}
