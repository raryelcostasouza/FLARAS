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
	import flaras.view.scene.*;
	import flash.events.*;
	import org.aswing.*;
	import org.aswing.border.*;
	import org.aswing.ext.*;
	
	public class AnimationPanel extends Form
	{
		private var _windowCircularAnimation:ViewWindowCircularAnimation;
		private var _windowP2PAnimation:ViewWindowP2PAnimation;
		
		private var _jcbHasAnimation:JCheckBox;
		private var _jrbCircularType:JRadioButton;
		private var _jrbP2PType:JRadioButton;
		private var _jbEditProperties:JButton;
		
		private var _ctrGUI:CtrGUI;
		
		public function AnimationPanel(ctrGUI:CtrGUI) 
		{						
			this._ctrGUI = ctrGUI;
			
			_windowCircularAnimation = new ViewWindowCircularAnimation(ctrGUI);
			_windowP2PAnimation = new ViewWindowP2PAnimation(ctrGUI);
			
			addRow(buildLine1());
			addRow(buildLine2());
			addRow(buildLine3());
			
			setComponentsStatus(false);
		}
		
		public function getWindowCircularAnimation():ViewWindowCircularAnimation
		{
			return _windowCircularAnimation;
		}
		
		public function getWindowP2PAnimation():ViewWindowP2PAnimation
		{
			return _windowP2PAnimation;
		}		
		
		private function setComponentsStatus(status:Boolean):void
		{
			_jrbCircularType.setEnabled(status);
			_jrbP2PType.setEnabled(status);
			_jbEditProperties.setEnabled(status);
		}
		
		private function buildLine1():JPanel
		{
			var northPanel:JPanel;
			
			northPanel = new JPanel(new FlowLayout(FlowLayout.LEFT));
			_jcbHasAnimation = new JCheckBox("Animation");
			_jcbHasAnimation.addActionListener(hasAnimationListener);
			
			northPanel.append(_jcbHasAnimation);
			
			return northPanel;
		}
		
		private function hasAnimationListener(e:Event):void
		{
			var newState:Boolean;
			
			newState = _jcbHasAnimation.isSelected();
			setComponentsStatus(newState);
			this._ctrGUI.listenerUpdateAnimationState(newState);
		}
		
		private function buildLine2():JPanel
		{
			var centerPanel:JPanel;
			var buttonGroup:ButtonGroup;
			
			centerPanel = new JPanel(new FlowLayout(FlowLayout.CENTER));
			centerPanel.setBorder(new TitledBorder(null, "Type", 1, TitledBorder.LEFT));
			centerPanel.setPreferredWidth(210);
			
			_jrbCircularType = new JRadioButton("Circular");
			_jrbCircularType.setSelected(true);
			_jrbP2PType = new JRadioButton("Point to point");
			
			_jrbCircularType.addActionListener(_ctrGUI.listenerChangeAnimationType);
			_jrbP2PType.addActionListener(_ctrGUI.listenerChangeAnimationType);
			
			buttonGroup = new ButtonGroup();
			buttonGroup.append(_jrbCircularType);
			buttonGroup.append(_jrbP2PType);
			
			centerPanel.append(_jrbCircularType);
			centerPanel.append(_jrbP2PType);
			
			return centerPanel;
		}
		
		private function buildLine3():JPanel
		{
			var southPanel:JPanel;
			
			southPanel = new JPanel(new FlowLayout(FlowLayout.CENTER));
			
			_jbEditProperties = new JButton("Edit properties");
			_jbEditProperties.addActionListener(listenerJBEditProperties);
			southPanel.append(_jbEditProperties);

			return southPanel;
		}
		
		private function listenerJBEditProperties(e:Event):void
		{
			if (_jrbCircularType.isSelected())
			{
				_windowCircularAnimation.setVisible(true);
			}
			else
			{
				_windowP2PAnimation.setVisible(true);
			}			
		}
		
		public function getHasAnimation():Boolean
		{
			return _jcbHasAnimation.isSelected();
		}
		
		
		public function setHasAnimation(hasAnimation:Boolean):void
		{
			_jcbHasAnimation.setSelected(hasAnimation);
			setComponentsStatus(hasAnimation);
		}
		
		public function setCircularAnimationType():void
		{
			_jrbCircularType.setSelected(true);
		}
		
		public function setP2PAnimationType():void
		{
			_jrbP2PType.setSelected(true);
		}
		
		public function getJcbHasAnimation():JCheckBox
		{
			return _jcbHasAnimation;
		}
		
		public function getAnimationType():String
		{
			if (_jrbCircularType.isSelected())
			{
				return "circular";
			}
			else
			{
				return "point to point";
			}
		}
	}
}