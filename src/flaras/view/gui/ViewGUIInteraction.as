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
		
		public function ViewGUIInteraction(ctrGUI:CtrGUI) 
		{
			var jw:JWindow;
			var mainPanel:JPanel;
			
			this._ctrGUI = ctrGUI;
			
			jw = new JWindow();
			jw.setContentPane(buildMainPanel());
			jw.setSizeWH(640, 100);
			jw.setLocationXY(0, 480);
			jw.show();
		}
		
		private function buildMainPanel():JPanel
		{
			var mainPanel:JPanel = new JPanel();
			
			mainPanel.append(buildInteractionPanel());
			mainPanel.append(buildViewPanel());
			mainPanel.append(buildAllPointsPanel());
			
			return mainPanel
		}
		
		private function buildInteractionPanel():JPanel
		{
			var jpInteractionPanel:JPanel = new JPanel();
			jpInteractionPanel.setBorder(new TitledBorder(null, "Interaction"));
			
			var jtbControlBackward:JToggleButton = new JToggleButton("Control Backward");
			var jtbControlForward:JToggleButton = new JToggleButton("Control Forward");
			var jtbInspection:JToggleButton = new JToggleButton("Inspection");
			
			jtbControlBackward.addActionListener(function(e:Event):void
			{
				if (jtbControlBackward.isSelected())
				{
					jtbControlForward.setSelected(false);
					jtbInspection.setSelected(false);
					
					_ctrGUI.getCtrMain().ctrMarker.changeControlMarkerType();
				}
				
			});
			jtbControlForward.addActionListener(function(e:Event):void
			{
				if (jtbControlForward.isSelected())
				{
					jtbControlBackward.setSelected(false);
					jtbInspection.setSelected(false);
					
					_ctrGUI.getCtrMain().ctrMarker.changeControlMarkerType();
				}
			});
			jtbInspection.addActionListener(function(e:Event):void
			{
				if (jtbInspection.isSelected)
				{
					jtbControlBackward.setSelected(false);
					jtbControlForward.setSelected(false);
					
					_ctrGUI.getCtrMain().ctrMarker.changeMarkerType();
				}
			});
			
			jpInteractionPanel.append(jtbInspection);
			jpInteractionPanel.append(jtbControlBackward);
			jpInteractionPanel.append(jtbControlForward);			
			
			return jpInteractionPanel;
		}
		
		private function buildViewPanel():JPanel
		{
			var jpViewPanel:JPanel = new JPanel();
			jpViewPanel.setBorder(new TitledBorder(null, "View"));
			
			var jtbMirrorScreen:JToggleButton = new JToggleButton("Mirror");
			var jtbMarkerPersistence:JToggleButton = new JToggleButton("Marker persistence");
			var jtbAuxSphere:JToggleButton = new JToggleButton("Aux sphere");
			
			jtbMirrorScreen.addActionListener(function(e:Event):void
			{
				_ctrGUI.getCtrMain().ctrMirror.toggleMirror(true);
			});
			jtbMarkerPersistence.addActionListener(function(e:Event):void
			{
				_ctrGUI.getCtrMain().ctrMarker.toggleRefMarkerPersistence();
			});
			jtbAuxSphere.addActionListener(function(e:Event):void
			{
				_ctrGUI.getCtrMain().ctrPoint.toggleVisibleAuxSphereOfPoints();
			});
			
			jpViewPanel.append(jtbMirrorScreen);
			jpViewPanel.append(jtbMarkerPersistence);
			jpViewPanel.append(jtbAuxSphere);
			
			return jpViewPanel;
		}
		
		private function buildAllPointsPanel():JPanel
		{
			var jpAllPointsPanel:JPanel = new JPanel();
			jpAllPointsPanel.setBorder(new TitledBorder(null, "All points"));
			
			var jbEnableAll:JButton = new JButton("Enable");
			var jbDisableAll:JButton = new JButton("Disable");
			
			jbEnableAll.addActionListener(function(e:Event):void
			{
				_ctrGUI.getCtrMain().ctrPoint.enableAllPoints();
			});
			jbDisableAll.addActionListener(function(e:Event):void
			{
				_ctrGUI.getCtrMain().ctrPoint.disableAllPoints(true);
			});
			
			jpAllPointsPanel.append(jbEnableAll);
			jpAllPointsPanel.append(jbDisableAll);
			
			return jpAllPointsPanel;
		}		
	}
}