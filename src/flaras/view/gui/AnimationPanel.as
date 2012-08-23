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
		private var _jcbHasAnimation:JCheckBox;
		private var _jrbX:JRadioButton;
		private var _jrbY:JRadioButton;
		private var _jrbZ:JRadioButton;
		private var _jtfRotationPeriod:JTextField;
		private var _jtfRotationRadius:JTextField;
		private var _jcbReverseRotation:JCheckBox;
		
		private var _ctrGUI:CtrGUI;
		
		public function AnimationPanel(ctrGUI:CtrGUI) 
		{						
			this._ctrGUI = ctrGUI;
			setBackgroundDecorator(new SolidBackground(UIManager.getColor("window")));
			
			addRow(buildLine1());
			addRow(buildLine2());
			addRow(buildLine3());
			addRow(buildLine4());
			addRow(buildLine5());
			
			setComponentsStatus(false);
		}
		
		private function setComponentsStatus(status:Boolean):void
		{
			_jtfRotationPeriod.setEnabled(status);
			_jrbX.setEnabled(status);
			_jrbY.setEnabled(status);
			_jrbZ.setEnabled(status);
			_jtfRotationRadius.setEnabled(status);
			_jcbReverseRotation.setEnabled(status);
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
			centerPanel.setBorder(new TitledBorder(null, "Rotation Axis", 1,TitledBorder.LEFT));
			
			_jrbX = new JRadioButton("X");
			_jrbX.setForeground(ASColor.RED);
			_jrbX.setSelected(true);
			_jrbX.addActionListener(_ctrGUI.listenerUpdateAnimationProperties);
			
			_jrbY = new JRadioButton("Y");
			_jrbY.setForeground(ASColor.BLUE);
			_jrbY.addActionListener(_ctrGUI.listenerUpdateAnimationProperties);
			
			_jrbZ = new JRadioButton("Z");
			_jrbZ.setForeground(ASColor.GREEN.darker().darker());
			_jrbZ.addActionListener(_ctrGUI.listenerUpdateAnimationProperties);
			
			buttonGroup = new ButtonGroup();
			buttonGroup.append(_jrbX);
			buttonGroup.append(_jrbY);
			buttonGroup.append(_jrbZ);
			
			centerPanel.append(_jrbX);
			centerPanel.append(_jrbY);
			centerPanel.append(_jrbZ);			
			
			return centerPanel;
		}
		
		private function buildLine3():JPanel
		{
			var southPanel:JPanel;
			var jlRotationSpeed:JLabel;
			var jlRotationUnit:JLabel;
			
			southPanel = new JPanel(new FlowLayout(FlowLayout.LEFT));
			
			jlRotationSpeed = new JLabel("Rotation period: ");
			_jtfRotationPeriod = new JTextField("10", 5);
			_jtfRotationPeriod.addEventListener(KeyboardEvent.KEY_UP, _ctrGUI.filterValidStrictPositiveCharFromTextField);
			_jtfRotationPeriod.addActionListener(_ctrGUI.listenerUpdateAnimationProperties);
			
			jlRotationUnit = new JLabel("seconds");
			
			southPanel.append(jlRotationSpeed);
			southPanel.append(_jtfRotationPeriod);			
			southPanel.append(jlRotationUnit);
			
			return southPanel;
		}
		
		public function buildLine4():JPanel
		{
			var panelLine4:JPanel;
			var jlRotationRadius:JLabel;
			
			panelLine4 = new JPanel(new FlowLayout(FlowLayout.LEFT));
			
			jlRotationRadius = new JLabel("Rotation radius: ");
			_jtfRotationRadius = new JTextField("0", 5);
			_jtfRotationRadius.addEventListener(KeyboardEvent.KEY_UP, _ctrGUI.filterValidStrictPositiveCharFromTextField);
			_jtfRotationRadius.addActionListener(_ctrGUI.listenerUpdateAnimationProperties);
			
			panelLine4.append(jlRotationRadius);
			panelLine4.append(_jtfRotationRadius);
			
			return panelLine4;			
		}
		
		public function buildLine5():JPanel
		{
			var jp5:JPanel = new JPanel(new FlowLayout(FlowLayout.LEFT));
				
			_jcbReverseRotation = new JCheckBox("Reverse rotation");
			_jcbReverseRotation.addActionListener(function():void
			{
				_ctrGUI.listenerUpdateAnimationProperties(null);	
			});
			jp5.append(_jcbReverseRotation);
			
			return jp5;
		}
		
		public function getHasAnimation():Boolean
		{
			return _jcbHasAnimation.isSelected();
		}
		
		public function getJTFRotationPeriod():JTextField
		{
			return _jtfRotationPeriod;
		}
		
		public function getAnimationRotationAxis():uint
		{
			if (_jrbX.isSelected())
			{
				return ViewAnimationScene.X_ROTATION_AXIS;
			}
			else if (_jrbY.isSelected())
			{
				return ViewAnimationScene.Y_ROTATION_AXIS;
			}
			else
			{
				return ViewAnimationScene.Z_ROTATION_AXIS;
			}
		}
		
		public function getJTFRotationRadius():JTextField
		{
			return _jtfRotationRadius;
		}
		
		public function getAnimationDirection():int
		{
			var rotationDirection:int;
			
			if (_jcbReverseRotation.isSelected())
			{
				rotationDirection = -1;
			}
			else
			{
				rotationDirection = 1;
			}
			
			return rotationDirection;
		}
		
		public function setHasAnimation(hasAnimation:Boolean):void
		{
			_jcbHasAnimation.setSelected(hasAnimation);
			setComponentsStatus(hasAnimation);
		}
		
		public function setAnimationPeriod(animationPeriod:Number):void
		{
			_jtfRotationPeriod.setText(animationPeriod+"")
		}
		
		public function setAnimationRotationAxis(rotationAxis:uint):void
		{
			if (rotationAxis == ViewAnimationScene.X_ROTATION_AXIS)
			{
				_jrbX.setSelected(true);
			}
			else if (rotationAxis == ViewAnimationScene.Y_ROTATION_AXIS)
			{
				_jrbY.setSelected(true);
			}
			else
			{
				_jrbZ.setSelected(true);
			}
		}
		
		public function setAnimationRadius(animationRadius:uint):void
		{
			_jtfRotationRadius.setText(animationRadius+"");
		}
		
		public function setAnimationRotationDirection(rotationDirection:int):void
		{
			if (rotationDirection == -1)
			{
				_jcbReverseRotation.setSelected(true);
			}
			else
			{
				_jcbReverseRotation.setSelected(false);
			}
		}
		
		public function getJcbHasAnimation():JCheckBox
		{
			return _jcbHasAnimation;
		}
	}
}