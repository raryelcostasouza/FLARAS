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

package flaras.userInterface.graphicUserInterfaceComponents 
{
	import flaras.util.StageReference;
	import flash.events.Event;
	import org.aswing.border.LineBorder;
	import org.aswing.BorderLayout;
	import org.aswing.FlowLayout;
	import org.aswing.GridLayout;
	import org.aswing.JButton;
	import org.aswing.JComboBox;
	import org.aswing.JFrame;
	import org.aswing.JLabel;
	import org.aswing.JPanel;
	
	public class SwapWindow extends JFrame 
	{
		private var jcb:JComboBox;
		private var jlCurrentScenePosition:JLabel;
		
		public function SwapWindow(swapFunction:Function) 
		{
			super(null, "Swap Scene Position", true);
			var mainPanel:JPanel;
			
			setDefaultCloseOperation(JFrame.HIDE_ON_CLOSE);
			//setResizable(false);
			setSizeWH(320, 170);
			setLocationXY(320 - getWidth()/2, 240 - getHeight()/2);
			
			mainPanel = new JPanel(new BorderLayout());
			
			mainPanel.append(buildNorthPanel(), BorderLayout.NORTH);
			mainPanel.append(buildCenterPanel(), BorderLayout.CENTER);
			mainPanel.append(buildSouthPanel(swapFunction), BorderLayout.SOUTH);
			
			setContentPane(mainPanel);
		}
		
		private function buildNorthPanel():JPanel
		{
			var jl:JLabel;
			var northPanel:JPanel;
			
			northPanel = new JPanel(new FlowLayout(FlowLayout.CENTER));
			jl = new JLabel("Set the new position for this scene on the scene list:")
			
			northPanel.append(jl);
			
			return northPanel;
		}
		
		private function buildCenterPanel():JPanel
		{
			var centerPanel:JPanel;
			var auxPanel:JPanel;
			var auxPanel2:JPanel;
			var jlCurrent:JLabel;
			var jlNew:JLabel;
			
			auxPanel = new JPanel(new FlowLayout(FlowLayout.LEFT));
			auxPanel2 = new JPanel(new FlowLayout(FlowLayout.LEFT)); 
			
			centerPanel = new JPanel(new GridLayout(2, 1));
			centerPanel.setBorder(new LineBorder());
			
			jlCurrent = new JLabel("Current position on the scene list:");
			jlCurrentScenePosition = new JLabel("0");
			auxPanel.append(jlCurrent);
			auxPanel.append(jlCurrentScenePosition);
				
			jlNew = new JLabel("New position on the scene list: ");
			jcb = new JComboBox();
			auxPanel2.append(jlNew);
			auxPanel2.append(jcb);
			
			centerPanel.append(auxPanel);
			centerPanel.append(auxPanel2);
			
			return centerPanel;
		}
		
		private function buildSouthPanel(swapFunction:Function):JPanel
		{
			var southPanel:JPanel;
			var jbOk:JButton;
			var jbCancel:JButton;
			
			southPanel = new JPanel(new FlowLayout(FlowLayout.CENTER));
			jbOk = new JButton("OK");
			jbOk.addActionListener( function(e:Event):void{
				swapFunction(parseInt(jcb.getSelectedItem()));
				closeSwapWindow(null);
			});
			
			jbCancel = new JButton("Cancel");
			jbCancel.addActionListener(closeSwapWindow);
						
			southPanel.append(jbOk);
			southPanel.append(jbCancel);
			
			return southPanel;
		}
		
		public function openSwapWindow(numberOfScenes:uint, currentScenePosition:uint):void
		{
			var comboBoxArray:Array;
			
			comboBoxArray = new Array();
			for (var i:uint = 0; i < numberOfScenes; i++)
			{
				comboBoxArray.push((i+1) + "");	
			}
			jcb.setListData(comboBoxArray);		
			jcb.setSelectedIndex(0);
			
			jlCurrentScenePosition.setText(currentScenePosition+"");
			setVisible(true);			
		}
		
		private function closeSwapWindow(e:Event):void
		{
			setVisible(false);
		}
		
	}

}