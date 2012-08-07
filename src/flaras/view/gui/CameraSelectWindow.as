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
	
	public class CameraSelectWindow extends JFrame
	{
		private var jcb:JComboBox;
		private var jlCurrentScenePosition:JLabel;
		private var _ctrMain:CtrMain;
		
		public function CameraSelectWindow(ctrMain:CtrMain) 
		{
			super(null, "Select camera", true);
			_ctrMain = ctrMain;
			
			var mainPanel:JPanel;
			
			setDefaultCloseOperation(JFrame.HIDE_ON_CLOSE);
			setResizable(false);
			setSizeWH(210, 130);
			setLocationXY(320 - getWidth()/2, 240 - getHeight()/2);
			
			mainPanel = new JPanel(new BorderLayout());
			
			mainPanel.append(buildCenterPanel(), BorderLayout.CENTER);
			mainPanel.append(buildSouthPanel(), BorderLayout.SOUTH);
			
			setContentPane(mainPanel);
		}
		
		private function buildCenterPanel():JPanel
		{
			var centerPanel:JPanel;
			var jl:JLabel;
			var auxPanel:JPanel;
			var auxPanel2:JPanel;
			
			centerPanel = new JPanel(new GridLayout(2,1));
			
			jl = new JLabel("Select the camera for video capture:");
			auxPanel2 = new JPanel(new FlowLayout(FlowLayout.LEFT));
			auxPanel2.append(jl);
			
			jcb = new JComboBox();
			jcb.setPreferredWidth(180);
			auxPanel = new JPanel(new FlowLayout(FlowLayout.LEFT));
			auxPanel.append(jcb);
			
			centerPanel.append(auxPanel2);
			centerPanel.append(auxPanel);
			
			return centerPanel;
		}
		
		private function buildSouthPanel():JPanel
		{
			var southPanel:JPanel;
			var jbOk:JButton;
			var jbCancel:JButton;
			
			southPanel = new JPanel(new FlowLayout(FlowLayout.CENTER));
			jbOk = new JButton("OK");
			jbOk.addActionListener( function(e:Event):void{
				_ctrMain.ctrCamera.cameraSelected(jcb.getSelectedIndex());
				closeWindow(null);
			});
			
			jbCancel = new JButton("Cancel");
			jbCancel.addActionListener(closeWindow);
						
			southPanel.append(jbOk);
			southPanel.append(jbCancel);
			
			return southPanel;
		}
		
		public function openWindow(vectorCameraNames:Vector.<String>, selectedCameraIndex:uint):void
		{
			var comboBoxArray:Array;
			
			comboBoxArray = new Array();
			for (var i:uint = 0; i < vectorCameraNames.length; i++)
			{
				comboBoxArray.push(vectorCameraNames[i]);	
			}
			jcb.setListData(comboBoxArray);		
			jcb.setSelectedIndex(selectedCameraIndex);
			
			setVisible(true);			
		}
		
		private function closeWindow(e:Event):void
		{
			setVisible(false);
		}	
	}
}