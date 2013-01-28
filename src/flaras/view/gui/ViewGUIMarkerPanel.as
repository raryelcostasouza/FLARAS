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
	import org.aswing.*;
	import org.aswing.border.*;
	import org.aswing.geom.*;
	
	public class ViewGUIMarkerPanel extends JTabbedPane
	{
		private var _ctrGUI:CtrGUI;
		private var _jrbRefMarkerBaseSphere:JRadioButton; 
		private var _jrbRefMarkerBasePlane:JRadioButton;
		
		public function ViewGUIMarkerPanel(pCtrGUI:CtrGUI) 
		{
			super();
			
			_ctrGUI = pCtrGUI;
			
			appendTab(buildTabProperties(), "", new LoadIcon("icons/external/properties.png", 24, 24, true), "Properties");
			appendTab(buildTabOperations(), "", new LoadIcon("icons/external/operations.png", 24, 24, true), "Operations");
			
			setBackgroundDecorator(new SolidBackground(UIManager.getColor("window")));
		}
		
		private function buildTabProperties():JPanel
		{
			var subPanel:JPanel;
			var tabProperties:JPanel;
			var bg:ButtonGroup;
			
			tabProperties = new JPanel(new BorderLayout());
			
			subPanel = new JPanel(new FlowLayout(FlowLayout.CENTER));
			subPanel.setBorder(new TitledBorder(null, "Cover type", TitledBorder.TOP, TitledBorder.LEFT));
			
			_jrbRefMarkerBasePlane = new JRadioButton("Plane");
			_jrbRefMarkerBasePlane.addActionListener(_ctrGUI.listenerSetMarkerBaseTypePlane);
			_jrbRefMarkerBaseSphere = new JRadioButton("Sphere"); 
			_jrbRefMarkerBaseSphere.addActionListener(_ctrGUI.listenerSetMarkerBaseTypeSphere);
			
			subPanel.append(_jrbRefMarkerBasePlane);
			subPanel.append(_jrbRefMarkerBaseSphere);
			_jrbRefMarkerBasePlane.setSelected(true);
			
			bg = new ButtonGroup();
			bg.append(_jrbRefMarkerBasePlane);
			bg.append(_jrbRefMarkerBaseSphere);
			
			tabProperties.append(subPanel, BorderLayout.CENTER);		
			
			return tabProperties;
		}
		
		private function buildTabOperations():JPanel
		{
			var tabOperations:JPanel;
			var jbAddPoint:JButton;
			var jbAddAttractRepulsionPoint:JButton;
			
			tabOperations = new JPanel(new FlowLayout(FlowLayout.CENTER));
			
			jbAddPoint = new JButton("Add Point", new LoadIcon("icons/external/add-point.png", 48, 48));
			jbAddPoint.addActionListener(_ctrGUI.listenerAddPoint);
			
			jbAddAttractRepulsionPoint = new JButton("Add Attraction/Repulsion Point");
			jbAddAttractRepulsionPoint.addActionListener(_ctrGUI.listenerAddPointAttractRepulse);
			
			tabOperations.append(jbAddPoint);
			tabOperations.append(jbAddAttractRepulsionPoint);
			
			return tabOperations;
		}
		
		public function setJRBMarkerBaseType(pBaseType:uint):void
		{
			if (pBaseType == CtrMarker.REF_BASE_RECTANGLE_PLANE)
			{
				_jrbRefMarkerBasePlane.setSelected(true);
			}
			else
			{
				_jrbRefMarkerBaseSphere.setSelected(true);
			}
		}		
	}
}