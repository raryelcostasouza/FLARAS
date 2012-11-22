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
	import flaras.controller.util.*;
	import flash.events.*;
	import org.aswing.*;
	
	public class ViewWindowMoveZAxis extends JFrame
	{
		private var _ctrInteraction:CtrInteraction;
		private var _jslZPosition:JSlider;
		private var _jtfRange:JTextField;
		
		public function ViewWindowMoveZAxis(ctrInteraction:CtrInteraction) 
		{
			super(null, "Z position", true);
			
			_ctrInteraction = ctrInteraction;	
			setDefaultCloseOperation(HIDE_ON_CLOSE);
			setResizable(false);
			
			setContentPane(buildMainPanel());
			setSizeWH(130, 225);
			setLocationXY(0, 480-getHeight());
		}
		
		private function buildMainPanel():JPanel
		{
			var mainPanel:JPanel;
			var auxPanel:JPanel;
			
			mainPanel = new JPanel(new BorderLayout());
			auxPanel = new JPanel(new FlowLayout(FlowLayout.CENTER));
			
			_jslZPosition = new JSlider(JSlider.VERTICAL, -500, 500, 0);
			_jslZPosition.addStateListener(listenerSlider);
			_jslZPosition.setPaintTicks(true);
			_jslZPosition.setShowValueTip(true);
			_jslZPosition.setPreferredHeight(150);
				
			auxPanel.append(_jslZPosition);
			
			mainPanel.append(auxPanel, BorderLayout.CENTER);			
			mainPanel.append(buildSouthPanel(), BorderLayout.SOUTH);
			
			return mainPanel;
		}	
		
		private function buildSouthPanel():JPanel
		{
			var southPanel:JPanel;
			var jlRange:JLabel = new JLabel("Range size:");
			_jtfRange = new JTextField("400", 4);
			
			_jtfRange.setToolTipText("The range of z values available on the slider above.\n"+
			"Ex: If the range is 100 and the current z position of the scene is 300,\n"+
			"it will be possible to move the scene on z axis from 250 (300-100/2)\n"+
			"to 350 (300+100/2) using the slider above.\n" +
			"For higher accuracy use low range values.");
			
			_jtfRange.addEventListener(KeyboardEvent.KEY_UP, JTFFilter.filterValidStrictIntegerPositive);
			_jtfRange.addActionListener(listenerSetRange);
				
			southPanel = new JPanel(new FlowLayout(FlowLayout.LEFT));
			southPanel.append(jlRange);
			southPanel.append(_jtfRange);		
			
			return southPanel;
		}
		
		private function listenerSetRange(e:Event):void
		{
			var newRange:int;
			
			newRange = int(_jtfRange.getText())
			if (newRange > 0)
			{
				updateSliderLimits(newRange, _jslZPosition.getValue());
			}			
		}
		
		private function listenerSlider(e:Event):void
		{
			var value:int;
			
			value = _jslZPosition.getValue();
			_ctrInteraction.moveAlongZAxisTo(value);
		}
		
		public function enableWindowMoveZAxis(zPos:int):void
		{			
			_jslZPosition.setValue(zPos);
			_jtfRange.setText("400");
			updateSliderLimits(400, zPos);
			
			setVisible(true);
		}
		
		private function updateSliderLimits(range:uint, initialZPos:int):void
		{
			_jslZPosition.setValue(initialZPos);
			_jslZPosition.setMaximum(initialZPos + range / 2);
			_jslZPosition.setMinimum(initialZPos - range / 2);
			_jslZPosition.setMajorTickSpacing(range / 5);
			_jslZPosition.setMajorTickSpacing(range / 10);
		}
	}
}