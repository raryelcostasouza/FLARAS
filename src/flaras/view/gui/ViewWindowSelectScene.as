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
	import flash.events.*;
	import org.aswing.*;
	import org.aswing.tree.*;
	
	public class ViewWindowSelectScene extends JFrame 
	{
		private var _jtree:JTree;
		private var _jbAddScene:JButton;
		private var _panelAttractRepulsion:ViewGUIAttractRepulsionPointPanel;
		
		public function ViewWindowSelectScene(pProjectTree:JTree, pPanelAttractRepulsion:ViewGUIAttractRepulsionPointPanel)
		{
			super(null, "Select scene", true);			
			
			_panelAttractRepulsion = pPanelAttractRepulsion;
			
			setContentPane(buildMainPanel(pProjectTree));
			pack();
		}
		
		private function buildMainPanel(pProjectTree:JTree):JPanel
		{
			var mainPanel:JPanel;
			var jsp:JScrollPane;			
			
			mainPanel = new JPanel(new BorderLayout());
			
			_jbAddScene = new JButton("Add Scene");
			_jbAddScene.addActionListener(listenerAddScene);
			
			_jtree = new JTree(pProjectTree.getModel());
			_jtree.setExpandsSelectedPaths(true);
			_jtree.getSelectionModel().setSelectionMode(DefaultTreeSelectionModel.SINGLE_TREE_SELECTION);
			_jtree.addSelectionListener(listenerSelection);
			
			jsp = new JScrollPane(_jtree);
			
			mainPanel.append(jsp, BorderLayout.CENTER);
			mainPanel.append(_jbAddScene, BorderLayout.SOUTH);
		
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
			
			_panelAttractRepulsion.addScene2List(pointIndex, sceneIndex);
			setVisible(false);
		}
		
		private function listenerSelection(e:Event):void
		{
			var node:DefaultMutableTreeNode;
			var prefix:String;
			
			node = DefaultMutableTreeNode(_jtree.getLastSelectedPathComponent());
			prefix = ViewGUIProjectTree.getLabelPrefix(node.getUserObject());
			
			if (prefix.indexOf("Scene") != -1)
			{
				_jbAddScene.setEnabled(true);
			}
			else
			{
				_jbAddScene.setEnabled(false);
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