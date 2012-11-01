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
	import air.net.ServiceMonitor;
	import flaras.controller.*;
	import flash.events.*;
	import org.aswing.*;
	
	public class ViewWindowInteractionSphere extends JFrame
	{
		private var _ctrGUI:CtrGUI;
		private var jSlSphereDistance:JSlider;
		private var jSlSphereSize:JSlider;
		
		public function ViewWindowInteractionSphere(ctrGUI:CtrGUI) 
		{
			super(null, "Interaction Sphere Properties", true);
			
			this._ctrGUI = ctrGUI;
			
			setDefaultCloseOperation(HIDE_ON_CLOSE);
			setResizable(false);
			
			setContentPane(buildMainPanel());
			setSizeWH(300, 125);
			setLocationXY(320 - getWidth()/2, 0);
		}
		
		private function buildMainPanel():JPanel
		{
			var mainPanel:JPanel = new JPanel(new BorderLayout());
			
			mainPanel.append(buildCenterPanel(), BorderLayout.CENTER);
			mainPanel.append(buildSouthPanel(), BorderLayout.SOUTH);
			
			return mainPanel;
		}
		
		private function buildCenterPanel():JPanel
		{
			var centerPanel:JPanel = new JPanel(new GridLayout(2, 2));
			var jpAux:JPanel = new JPanel(new FlowLayout(FlowLayout.LEFT));
			var jpAux2:JPanel = new JPanel(new FlowLayout(FlowLayout.LEFT));
			
			var jlSphereSize:JLabel = new JLabel("Sphere Size:");
			jSlSphereSize = new JSlider(AsWingConstants.HORIZONTAL, 1, 251, CtrMarker.DEFAULT_SPHERE_SIZE);
			jSlSphereSize.setMajorTickSpacing(50);
			jSlSphereSize.setMinorTickSpacing(25);
			jSlSphereSize.setPaintTicks(true);
			jSlSphereSize.addStateListener(listenerSliderSize);
			
			jpAux.append(jlSphereSize);
			
			var jlSphereDistance:JLabel = new JLabel("Sphere Distance:");
			jSlSphereDistance = new JSlider(AsWingConstants.HORIZONTAL, 0, 250, CtrMarker.DEFAULT_SPHERE_DISTANCE);
			jSlSphereDistance.setMajorTickSpacing(50);
			jSlSphereDistance.setMinorTickSpacing(25);
			jSlSphereDistance.setPaintTicks(true);
			jSlSphereDistance.addStateListener(listenerSliderDistance);
			
			jpAux2.append(jlSphereDistance);
			
			centerPanel.append(jpAux);
			centerPanel.append(jSlSphereSize);
			
			centerPanel.append(jpAux2);
			centerPanel.append(jSlSphereDistance);
			
			return centerPanel;
		}
		
		private function buildSouthPanel():JPanel
		{
			var southPanel:JPanel = new JPanel();
			
			var jbResetDefaults:JButton = new JButton("Reset to default");
			jbResetDefaults.addActionListener(listenerReset);
			
			southPanel.append(jbResetDefaults);
			
			return southPanel;
		}
		
		private function listenerReset(e:Event):void
		{
			_ctrGUI.getCtrMain().ctrMarker.resetInteractionMarkerSphereProperties();
			jSlSphereDistance.setValue(CtrMarker.DEFAULT_SPHERE_DISTANCE);
			jSlSphereSize.setValue(CtrMarker.DEFAULT_SPHERE_SIZE);
		}
		
		private function listenerSliderSize(e:Event):void
		{
			var size:int;
			
			size = jSlSphereSize.getValue();
			_ctrGUI.getCtrMain().ctrMarker.updateInteractionSphereSize(size);
		}
		
		private function listenerSliderDistance(e:Event):void
		{
			var distance:int;
			
			distance = jSlSphereDistance.getValue();			
			_ctrGUI.getCtrMain().ctrMarker.updateInteractionSphereDistance(distance);
		}
		
		public function setSliderDistance(distance:int):void
		{
			jSlSphereDistance.setValue(distance);
		}
		
		public function setSliderSize(size:int):void
		{
			jSlSphereSize.setValue(size);
		}
		
	}

}