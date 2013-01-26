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
	import org.aswing.ext.*;
	
	public class ViewGUIAttractRepulsionPointPanel extends ViewGUIPointPanel
	{		
		private var _vlm:VectorListModel;
		private var _jlistScenes:JList;
		private var _windowSelectScene:ViewWindowSelectScene;
		
		public function ViewGUIAttractRepulsionPointPanel(pCtrGUI:CtrGUI, pProjectTree:JTree) 
		{
			super(pCtrGUI);
			
			_windowSelectScene = new ViewWindowSelectScene(pProjectTree);
			_tabProperties.remove(_jcbMovableScenes);
			appendTab(buildTabAttractRepulsion(), "A/R", null, "Attraction/Repulsion");
		}		
		
		private function buildTabAttractRepulsion():JPanel
		{
			var tabAttractionRepulsion:JPanel;
			var jrbAttraction:JRadioButton;
			var jrbRepulsion:JRadioButton;
			var jspList:JScrollPane;
			var vlm:VectorListModel;
			var bg:ButtonGroup;
			var formTab:Form;
			
			tabAttractionRepulsion = new JPanel(new FlowLayout(FlowLayout.CENTER));
			
			jrbAttraction = new JRadioButton("Scenes to attract");
			jrbAttraction.setSelected(true);			
			jrbRepulsion = new JRadioButton("Scenes to repulse");
			
			bg = new ButtonGroup();
			bg.append(jrbAttraction);
			bg.append(jrbRepulsion);
			
			_vlm = new VectorListModel();
			
			_jlistScenes = new JList(_vlm);
			_jlistScenes.setSelectionMode(JList.SINGLE_SELECTION);
			
			jspList = new JScrollPane(_jlistScenes);
			jspList.setBorder(new TitledBorder(null, "List of scenes", TitledBorder.TOP, TitledBorder.LEFT));
			jspList.setPreferredHeight(150);
			jspList.setPreferredWidth(200);
			
			formTab = new Form();
			formTab.addRow(jrbAttraction);
			formTab.addRow(jrbRepulsion);
			formTab.addRow(jspList);
			formTab.addRow(buildButtonsRow());
			
			tabAttractionRepulsion.append(formTab);
			
			return tabAttractionRepulsion;
		}
		
		private function buildButtonsRow():JPanel
		{
			var buttonsPanel:JPanel;
			var jbAddScene:JButton;
			var jbRemScene:JButton;
			
			buttonsPanel = new JPanel(new FlowLayout(FlowLayout.CENTER));
			
			jbAddScene = new JButton("Add");
			jbRemScene = new JButton("Remove");
			
			jbAddScene.addActionListener(listenerAddToList);
			jbRemScene.addActionListener(listenerRemoveFromList);
			
			buttonsPanel.append(jbAddScene);
			buttonsPanel.append(jbRemScene);
			
			return buttonsPanel;
		}
		
		private function listenerAddToList(e:Event):void
		{
			_vlm.append("hello");
			_windowSelectScene.setVisible(true);
		}
		
		private function listenerRemoveFromList(e:Event):void
		{
			trace(_jlistScenes.getSelectedIndex());
			_vlm.removeElementAt(_jlistScenes.getSelectedIndex());
		}
		
	}
}