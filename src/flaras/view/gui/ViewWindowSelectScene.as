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
	import flaras.controller.CtrGUI;
	import flash.events.*;
	import org.aswing.*;
	import org.aswing.tree.*;
	
	public class ViewWindowSelectScene extends JFrame 
	{
		private var _jtree:JTree;
		private var _jbAddScene:JButton;
		private var _panelAttractRepulsion:ViewGUIAttractRepulsionPointPanel;
		private var _ctrGUI:CtrGUI;
		
		public function ViewWindowSelectScene(pProjectTree:JTree, pPanelAttractRepulsion:ViewGUIAttractRepulsionPointPanel, pCtrGUI:CtrGUI)
		{
			super(null, "Select scene to attract", true);			
			
			_ctrGUI = pCtrGUI;
			
			_panelAttractRepulsion = pPanelAttractRepulsion;
			
			setContentPane(buildMainPanel(pProjectTree));
			setSizeWH(250, 300);
			setLocationXY(320 - getWidth() / 2, 240 - getHeight() / 2);
			setResizable(false);
		}
		
		private function buildMainPanel(pProjectTree:JTree):JPanel
		{
			var mainPanel:JPanel;
			var jsp:JScrollPane;
			var auxPanel:JPanel;
			
			mainPanel = new JPanel(new BorderLayout());
			
			_jbAddScene = new JButton("Add Scene");
			_jbAddScene.addActionListener(listenerAddScene);
			
			auxPanel = new JPanel(new FlowLayout(FlowLayout.CENTER));
			auxPanel.append(_jbAddScene);
			
			_jtree = new JTree(pProjectTree.getModel());
			_jtree.setExpandsSelectedPaths(true);
			_jtree.getSelectionModel().setSelectionMode(DefaultTreeSelectionModel.SINGLE_TREE_SELECTION);
			_jtree.addSelectionListener(listenerSelection);
			
			jsp = new JScrollPane(_jtree);
			
			mainPanel.append(jsp, BorderLayout.CENTER);
			mainPanel.append(auxPanel, BorderLayout.SOUTH);
		
			return mainPanel;
		}
		
		private function listenerAddScene(e:Event):void
		{
			var selectedSceneNode:DefaultMutableTreeNode;
			var pointNode:DefaultMutableTreeNode;
			var pointIndex:uint;
			var sceneIndex:uint;
			
			selectedSceneNode = DefaultMutableTreeNode(_jtree.getLastSelectedPathComponent());
			pointNode = DefaultMutableTreeNode(selectedSceneNode.getParent());
			pointIndex = pointNode.getParent().getIndex(pointNode);
			sceneIndex = selectedSceneNode.getParent().getIndex(selectedSceneNode);
			
			_ctrGUI.actionAddRefScene2Attract(pointIndex, sceneIndex);
		}
		
		private function listenerSelection(e:Event):void
		{
			var node:DefaultMutableTreeNode;
			var prefixNode:String;
			var parentNode:DefaultMutableTreeNode;
			var prefixParentNode:String;
			
			node = DefaultMutableTreeNode(_jtree.getLastSelectedPathComponent());			
			
			//node.getParent() != null -> the node is not Ref. Marker, which is the root
			if (node != null && node.getParent()!=null)
			{
				parentNode = DefaultMutableTreeNode(node.getParent());
				
				prefixNode = ViewGUIProjectTree.getLabelPrefix(node.getUserObject());
				prefixParentNode = ViewGUIProjectTree.getLabelPrefix(parentNode.getUserObject());
			
				if (prefixNode.indexOf("Scene") != -1 && prefixParentNode.indexOf("Point (A/R)") == -1 )
				{
					_jbAddScene.setEnabled(true);
				}
				else
				{
					_jbAddScene.setEnabled(false);
				}
			}			
		}
		
		public function showWindow():void
		{
			_jbAddScene.setEnabled(false);
			_jtree.updateUI();
			setVisible(true);
		}
	}
}