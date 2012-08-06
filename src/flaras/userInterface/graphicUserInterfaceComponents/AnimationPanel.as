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
	import flaras.entity.object3D.*;
	import flaras.userInterface.*;
	import flash.events.*;
	import org.aswing.*;
	import org.aswing.border.*;
	import org.aswing.ext.*;
	
	public class AnimationPanel extends Form
	{
		private var jcbHasAnimation:JCheckBox;
		private var jrbX:JRadioButton;
		private var jrbY:JRadioButton;
		private var jrbZ:JRadioButton;
		private var jtfRotationPeriod:JTextField;
		private var jtfRotationRadius:JTextField;
		private var jcbReverseRotation:JCheckBox;
		
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
			jtfRotationPeriod.setEnabled(status);
			jrbX.setEnabled(status);
			jrbY.setEnabled(status);
			jrbZ.setEnabled(status);
			jtfRotationRadius.setEnabled(status);
			jcbReverseRotation.setEnabled(status);
		}
		
		private function buildLine1():JPanel
		{
			var northPanel:JPanel;
			
			northPanel = new JPanel(new FlowLayout(FlowLayout.LEFT));
			jcbHasAnimation = new JCheckBox("Has animation?");
			jcbHasAnimation.addActionListener(hasAnimationListener);
			
			northPanel.append(jcbHasAnimation);
			
			return northPanel;
		}
		
		private function hasAnimationListener(e:Event):void
		{
			var newState:Boolean;
			
			newState = jcbHasAnimation.isSelected();
			setComponentsStatus(newState);
			this._ctrGUI.updateAnimationState(newState);
		}
		
		private function buildLine2():JPanel
		{
			var centerPanel:JPanel;
			var buttonGroup:ButtonGroup;
			
			centerPanel = new JPanel(new FlowLayout(FlowLayout.CENTER));
			centerPanel.setBorder(new TitledBorder(null, "Rotation Axis", 1,TitledBorder.LEFT));
			
			jrbX = new JRadioButton("X");
			jrbX.setSelected(true);
			jrbX.addActionListener(_ctrGUI.updateAnimationProperties);
			
			jrbY = new JRadioButton("Y");
			jrbY.addActionListener(_ctrGUI.updateAnimationProperties);
			
			jrbZ = new JRadioButton("Z");
			jrbZ.addActionListener(_ctrGUI.updateAnimationProperties);
			
			buttonGroup = new ButtonGroup();
			buttonGroup.append(jrbX);
			buttonGroup.append(jrbY);
			buttonGroup.append(jrbZ);
			
			centerPanel.append(jrbX);
			centerPanel.append(jrbY);
			centerPanel.append(jrbZ);			
			
			return centerPanel;
		}
		
		private function buildLine3():JPanel
		{
			var southPanel:JPanel;
			var jlRotationSpeed:JLabel;
			var jlRotationUnit:JLabel;
			
			southPanel = new JPanel(new FlowLayout(FlowLayout.LEFT));
			
			jlRotationSpeed = new JLabel("Rotation period: ");
			jtfRotationPeriod = new JTextField("10", 5);
			jtfRotationPeriod.addEventListener(KeyboardEvent.KEY_UP, _ctrGUI.filterValidStrictPositiveCharFromTextField);
			jtfRotationPeriod.addActionListener(_ctrGUI.updateAnimationProperties);
			
			jlRotationUnit = new JLabel("seconds");
			
			southPanel.append(jlRotationSpeed);
			southPanel.append(jtfRotationPeriod);			
			southPanel.append(jlRotationUnit);
			
			return southPanel;
		}
		
		public function buildLine4():JPanel
		{
			var panelLine4:JPanel;
			var jlRotationRadius:JLabel;
			
			panelLine4 = new JPanel(new FlowLayout(FlowLayout.LEFT));
			
			jlRotationRadius = new JLabel("Rotation radius: ");
			jtfRotationRadius = new JTextField("0", 5);
			jtfRotationRadius.addEventListener(KeyboardEvent.KEY_UP, _ctrGUI.filterValidStrictPositiveCharFromTextField);
			jtfRotationRadius.addActionListener(_ctrGUI.updateAnimationProperties);
			
			panelLine4.append(jlRotationRadius);
			panelLine4.append(jtfRotationRadius);
			
			return panelLine4;			
		}
		
		public function buildLine5():JPanel
		{
			var jp5:JPanel = new JPanel(new FlowLayout(FlowLayout.LEFT));
				
			jcbReverseRotation = new JCheckBox("Reverse rotation");
			jcbReverseRotation.addActionListener(function():void
			{
				_ctrGUI.updateAnimationProperties(null);	
			});
			jp5.append(jcbReverseRotation);
			
			return jp5;
		}
		
		public function getHasAnimation():Boolean
		{
			return jcbHasAnimation.isSelected();
		}
		
		public function getAnimationPeriod():Number
		{
			return parseFloat(jtfRotationPeriod.getText());
		}
		
		public function getAnimationRotationAxis():uint
		{
			if (jrbX.isSelected())
			{
				return Animation.X_ROTATION_AXIS;
			}
			else if (jrbY.isSelected())
			{
				return Animation.Y_ROTATION_AXIS;
			}
			else
			{
				return Animation.Z_ROTATION_AXIS;
			}
		}
		
		public function getAnimationRadius():uint
		{
			return parseInt(jtfRotationRadius.getText());
		}
		
		public function getAnimationDirection():int
		{
			var rotationDirection:int;
			
			if (jcbReverseRotation.isSelected())
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
			jcbHasAnimation.setSelected(hasAnimation);
			setComponentsStatus(hasAnimation);
		}
		
		public function setAnimationPeriod(animationPeriod:Number):void
		{
			jtfRotationPeriod.setText(animationPeriod+"")
		}
		
		public function setAnimationRotationAxis(rotationAxis:uint):void
		{
			if (rotationAxis == Animation.X_ROTATION_AXIS)
			{
				jrbX.setSelected(true);
			}
			else if (rotationAxis == Animation.Y_ROTATION_AXIS)
			{
				jrbY.setSelected(true);
			}
			else
			{
				jrbZ.setSelected(true);
			}
		}
		
		public function setAnimationRadius(animationRadius:uint):void
		{
			jtfRotationRadius.setText(animationRadius+"");
		}
		
		public function setAnimationRotationDirection(rotationDirection:int):void
		{
			if (rotationDirection == -1)
			{
				jcbReverseRotation.setSelected(true);
			}
			else
			{
				jcbReverseRotation.setSelected(false);
			}
		}
		
		public function getJcbHasAnimation():JCheckBox
		{
			return jcbHasAnimation;
		}
	}
}