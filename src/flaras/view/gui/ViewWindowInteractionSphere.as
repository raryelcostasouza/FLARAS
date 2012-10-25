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
	import org.aswing.*;
	
	public class ViewWindowInteractionSphere extends JFrame
	{
		public function ViewWindowInteractionSphere() 
		{
			super(null, "Interaction Sphere Properties", true);
			
			setDefaultCloseOperation(HIDE_ON_CLOSE);
			setResizable(false);
			
			setContentPane(buildMainPanel());
			pack();
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
			
			var jlSphereSize:JLabel = new JLabel("Sphere Size");
			var jSlSphereSize:JSlider = new JSlider();
			
			var jlSphereDistance:JLabel = new JLabel("Sphere Distance");
			var jSlSphereDistance:JSlider = new JSlider();
			
			centerPanel.append(jlSphereSize);
			centerPanel.append(jSlSphereSize);
			
			centerPanel.append(jlSphereDistance);
			centerPanel.append(jSlSphereDistance);
			
			return centerPanel;
		}
		
		private function buildSouthPanel():JPanel
		{
			var southPanel:JPanel = new JPanel();
			
			var jbResetDefaults:JButton = new JButton("Reset to default");
			southPanel.append(jbResetDefaults);
			
			return southPanel;
		}
	}

}