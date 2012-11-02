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
	import flash.events.*;
	import org.aswing.*;
	import org.aswing.border.*;
	
	public class ViewGUIInteraction 
	{
		private var _ctrGUI:CtrGUI;
		private var _viewWindowInteractionSphere:ViewWindowInteractionSphere;
		
		public function ViewGUIInteraction(ctrGUI:CtrGUI) 
		{
			var jw:JWindow;
			var mainPanel:JPanel;
			
			this._ctrGUI = ctrGUI;
			this._viewWindowInteractionSphere = new ViewWindowInteractionSphere(_ctrGUI);
			
			jw = new JWindow();
			jw.setContentPane(buildMainPanel());
			jw.setSizeWH(640, 60);
			jw.setLocationXY(0, 480);
			jw.show();
		}
		
		private function buildMainPanel():JPanel
		{
			var mainPanel:JPanel = new JPanel();
			var jtbar:JToolBar = new JToolBar();
			
			buildInteractionPanel(jtbar);
			buildViewPanel(jtbar);
			buildAllPointsPanel(jtbar);
			
			mainPanel.append(jtbar);
			
			return mainPanel
		}
		
		private function buildInteractionPanel(pJToolBar:JToolBar):void
		{			
			var jtbControlBackward:JToggleButton = new JToggleButton(null, new LoadIcon("icons/external/backward.png"));
			var jtbControlForward:JToggleButton = new JToggleButton(null, new LoadIcon("icons/external/forward.png"));
			var jtbInspection:JToggleButton = new JToggleButton(null, new LoadIcon("icons/external/inspection.png"));
			var jtbMove:JToggleButton = new JToggleButton(null, new LoadIcon("icons/external/move.png"));
			
			jtbInspection.setSelected(true);
			
			jtbControlBackward.setToolTipText("Backward");
			jtbControlForward.setToolTipText("Forward");
			jtbInspection.setToolTipText("Inspection");
			jtbMove.setToolTipText("Move");
			
			jtbControlBackward.addActionListener(function(e:Event):void
			{
				if (jtbControlBackward.isSelected())
				{
					jtbControlForward.setSelected(false);
					jtbInspection.setSelected(false);
					jtbMove.setSelected(false);
					
					_ctrGUI.getCtrMain().ctrMarker.setMarkerType2ControlBackward();
				}
			});
			jtbControlForward.addActionListener(function(e:Event):void
			{
				if (jtbControlForward.isSelected())
				{
					jtbControlBackward.setSelected(false);
					jtbInspection.setSelected(false);
					jtbMove.setSelected(false);
					
					_ctrGUI.getCtrMain().ctrMarker.setMarkerType2ControlForward();
				}
			});
			jtbInspection.addActionListener(function(e:Event):void
			{
				if (jtbInspection.isSelected())
				{
					jtbControlBackward.setSelected(false);
					jtbControlForward.setSelected(false);
					jtbMove.setSelected(false);
					
					_ctrGUI.getCtrMain().ctrMarker.setMarkerType2Inspection();
				}
			});
			jtbMove.addActionListener(function(e:Event):void
			{
				if (jtbMove.isSelected())
				{
					jtbControlBackward.setSelected(false);
					jtbControlForward.setSelected(false);
					jtbInspection.setSelected(false);
				}
			});
			
			pJToolBar.append(jtbInspection);
			pJToolBar.append(jtbControlBackward);
			pJToolBar.append(jtbControlForward);
			pJToolBar.append(jtbMove);
		}
		
		private function buildViewPanel(pJToolBar:JToolBar):void
		{			
			var jtbMirrorScreen:JToggleButton = new JToggleButton(null, new LoadIcon("icons/external/camera-mirror.png"));			
			var jtbMarkerPersistence:JToggleButton = new JToggleButton(null, new LoadIcon("icons/markerIcon.png"));			
			var jbInteractionMarker:JButton = new JButton(null, new LoadIcon("icons/interactionMarkerIcon.png"));
			
			jtbMirrorScreen.setToolTipText("Mirror camera");
			jtbMarkerPersistence.setToolTipText("Marker persistence");
			jbInteractionMarker.setToolTipText("Interaction marker properties");
			
			jtbMirrorScreen.addActionListener(function(e:Event):void
			{
				_ctrGUI.getCtrMain().ctrMirror.toggleMirror(true);
			});
			jtbMarkerPersistence.addActionListener(function(e:Event):void
			{
				_ctrGUI.getCtrMain().ctrMarker.toggleRefMarkerPersistence();
			});
			jbInteractionMarker.addActionListener(function(e:Event):void
			{
				_viewWindowInteractionSphere.setVisible(true);
			});
			
			
			pJToolBar.append(new JSeparator(JSeparator.VERTICAL));
			pJToolBar.append(jtbMirrorScreen);
			pJToolBar.append(jtbMarkerPersistence);
			pJToolBar.append(jbInteractionMarker);
		}
		
		private function buildAllPointsPanel(pJToolBar:JToolBar):void
		{			
			var jbEnableAll:JButton = new JButton(null, new LoadIcon("icons/external/enable.png"));
			var jbDisableAll:JButton = new JButton(null, new LoadIcon("icons/external/disable.png"));
			
			jbEnableAll.setToolTipText("Enable all points");
			jbDisableAll.setToolTipText("Disable all points");
			
			jbEnableAll.addActionListener(function(e:Event):void
			{
				_ctrGUI.getCtrMain().ctrPoint.enableAllPoints();
			});
			jbDisableAll.addActionListener(function(e:Event):void
			{
				_ctrGUI.getCtrMain().ctrPoint.disableAllPoints(true);
			});
			
			pJToolBar.append(new JSeparator(JSeparator.VERTICAL));
			pJToolBar.append(jbEnableAll);
			pJToolBar.append(jbDisableAll);
		}
		
		public function getViewWindowInteractionSphere():ViewWindowInteractionSphere 
		{ 
			return _viewWindowInteractionSphere; 
		}
	}
}