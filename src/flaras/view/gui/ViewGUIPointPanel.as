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
	import org.aswing.geom.*;

	public class ViewGUIPointPanel extends JTabbedPane
	{
		private var _jtfPointLabel:JTextField;
		private var _ctrGUI:CtrGUI;
		private var _jtfPointTrX:JTextField;
		private var _jtfPointTrY:JTextField;
		private var _jtfPointTrZ:JTextField;
		protected var _jcbMovableScenes:JCheckBox;
		
		protected var _tabProperties:JPanel;
		protected var _tabOperations:JPanel;
			
		
		public function ViewGUIPointPanel(pCtrGUI:CtrGUI) 
		{
			super();
			
			_ctrGUI = pCtrGUI;
			
			appendTab(buildTabProperties(), "", new LoadIcon("icons/external/properties.png", 24, 24, true), "Properties");
			appendTab(buildTabOperations(), "", new LoadIcon("icons/external/operations.png", 24, 24, true), "Operations")
			
			setBackgroundDecorator(new SolidBackground(UIManager.getColor("window")));
		}
		
		private function buildTabProperties():JPanel
		{
			var subPanel:JPanel;
			var subPanel2:JPanel;
			var jlPointTrX:JLabel;
			var jlPointTrY:JLabel;
			var jlPointTrZ:JLabel;
			
			_tabProperties = new JPanel(new FlowLayout(FlowLayout.CENTER));
			
			subPanel = new JPanel();
			subPanel.setBorder(new TitledBorder(null, "Point label", TitledBorder.TOP, TitledBorder.LEFT));
			_jtfPointLabel = new JTextField("", 20);
			_jtfPointLabel.addActionListener(_ctrGUI.listenerUpdatePointLabel);
			subPanel.append(_jtfPointLabel);
			
			_tabProperties.append(subPanel);			
			
			subPanel2 = new JPanel();
			subPanel2.setBorder(new TitledBorder(null, "Translation", TitledBorder.TOP, TitledBorder.LEFT));
			jlPointTrX = new JLabel("X");
			jlPointTrX.setForeground(ASColor.RED);
			jlPointTrY = new JLabel("Y");
			jlPointTrY.setForeground(ASColor.BLUE);
			jlPointTrZ = new JLabel("Z");
			jlPointTrZ.setForeground(ASColor.GREEN.darker());
			
			_jtfPointTrX = new JTextField("", 4);
			_jtfPointTrY = new JTextField("", 4);
			_jtfPointTrZ = new JTextField("", 4);
			
			_jtfPointTrX.addEventListener(KeyboardEvent.KEY_UP, _ctrGUI.filterValidCharFromTextField);
			_jtfPointTrY.addEventListener(KeyboardEvent.KEY_UP, _ctrGUI.filterValidCharFromTextField);
			_jtfPointTrZ.addEventListener(KeyboardEvent.KEY_UP, _ctrGUI.filterValidCharFromTextField);
			
			_jtfPointTrX.addActionListener(_ctrGUI.listenerUpdatePointPosition);
			_jtfPointTrY.addActionListener(_ctrGUI.listenerUpdatePointPosition);
			_jtfPointTrZ.addActionListener(_ctrGUI.listenerUpdatePointPosition);
			
			subPanel2.append(jlPointTrX);
			subPanel2.append(_jtfPointTrX);
			subPanel2.append(jlPointTrY);
			subPanel2.append(_jtfPointTrY);
			subPanel2.append(jlPointTrZ);
			subPanel2.append(_jtfPointTrZ);
			
			_tabProperties.append(subPanel2);
			
			_jcbMovableScenes = new JCheckBox("Enable move interaction for scenes");
			_jcbMovableScenes.addActionListener(_ctrGUI.listenerUpdateMoveInteractionForScenes);
			
			_tabProperties.append(_jcbMovableScenes);
			
			return _tabProperties;
		}
		
		private function buildTabOperations():JPanel
		{
			var jbRemPoint:JButton;
			var jbAdd3DObjScene:JButton;
			var jbAddTextureScene:JButton;
			var jbAddVideoScene:JButton;
			
			_tabOperations = new JPanel(new FlowLayout(FlowLayout.CENTER));
			
			jbAdd3DObjScene = new JButton("Add 3D Obj Scene", new LoadIcon("icons/external/obj3d.png", 48, 48));
			jbAddTextureScene = new JButton("Add Texture Scene", new LoadIcon("icons/external/texture.png", 48, 48));
			jbAddVideoScene = new JButton("Add Video Scene", new LoadIcon("icons/external/video.png", 48, 48));
			jbRemPoint = new JButton("Delete point", new LoadIcon("icons/external/delete.png", 48, 48));
			
			jbAdd3DObjScene.setPreferredWidth(150);
			jbAddVideoScene.setPreferredWidth(150);
			jbRemPoint.setPreferredWidth(150);
			
			jbAdd3DObjScene.addActionListener(_ctrGUI.listenerAddObj3DScene);
			jbAddTextureScene.addActionListener(_ctrGUI.listenerAddTextureScene);
			jbAddVideoScene.addActionListener(_ctrGUI.listenerAddVideoScene);
			jbRemPoint.addActionListener(_ctrGUI.listenerRemovePoint);
			
			_tabOperations.append(jbAdd3DObjScene);			
			_tabOperations.append(jbAddTextureScene);			
			_tabOperations.append(jbAddVideoScene);			
			_tabOperations.append(jbRemPoint);
			
			return _tabOperations;
		}	
		
		public function getJTFPointLabel():JTextField
		{
			return _jtfPointLabel;
		}
		
		public function getJTFPointTrX():JTextField 
		{
			return _jtfPointTrX;
		}
		
		public function getJTFPointTrY():JTextField 
		{
			return _jtfPointTrY;
		}
		
		public function getJTFPointTrZ():JTextField 
		{
			return _jtfPointTrZ;
		}
		
		public function getJCBMoveInteractionForScenes():JCheckBox
		{
			return _jcbMovableScenes;
		}
	}

}