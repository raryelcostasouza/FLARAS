package flaras.view.gui 
{
	import flaras.controller.*;
	import flaras.view.scene.ViewAnimationScene;
	import flaras.view.scene.ViewCircularAnimationScene;
	import flash.events.*;
	import org.aswing.*;
	import org.aswing.border.*;
	import org.aswing.ext.*;
	public class ViewWindowCircularAnimation extends JFrame
	{	
		private var _ctrGUI:CtrGUI;
		
		private var _jrbX:JRadioButton;
		private var _jrbY:JRadioButton;
		private var _jrbZ:JRadioButton;
		private var _jtfRotationPeriod:JTextField;
		private var _jtfRotationRadiusA:JTextField;
		private var _jtfRotationRadiusB:JTextField;
		private var _jcbRadiusBCloneRadiusA:JCheckBox;
		private var _jcbReverseRotation:JCheckBox;
		
		public function ViewWindowCircularAnimation(pCtrGUI:CtrGUI ) 
		{
			var mainPanel:JPanel;
			super(null, "Circular animation", true);
				
			_ctrGUI = pCtrGUI;
			
			setDefaultCloseOperation(JFrame.HIDE_ON_CLOSE);
			
			mainPanel = new JPanel(new BorderLayout());
			mainPanel.append(buildMainPanelForm(), BorderLayout.CENTER);
			
			setContentPane(mainPanel);
			pack();
			setLocationXY(320 - getWidth()/2, 240 - getHeight() / 2)
			setResizable(false);
		}
		
		private function buildMainPanelForm():Form
		{
			var objForm:Form;
			
			objForm = new Form();
			
			objForm.addRow(buildLine1());
			objForm.addRow(buildLine2());
			objForm.addRow(buildLine3());
			objForm.addRow(buildLine4());
			objForm.addRow(buildLine5());
			
			return objForm;
		}
		
		private function buildLine1():JPanel
		{
			var centerPanel:JPanel;
			var buttonGroup:ButtonGroup;
			
			centerPanel = new JPanel(new FlowLayout(FlowLayout.CENTER));
			centerPanel.setBorder(new TitledBorder(null, "Rotation Axis", 1,TitledBorder.LEFT));
			
			_jrbX = new JRadioButton("X");
			_jrbX.setForeground(ASColor.RED);
			_jrbX.setSelected(true);
			_jrbX.addActionListener(_ctrGUI.listenerUpdateCircularAnimationProperties);
			
			_jrbY = new JRadioButton("Y");
			_jrbY.setForeground(ASColor.BLUE);
			_jrbY.addActionListener(_ctrGUI.listenerUpdateCircularAnimationProperties);
			
			_jrbZ = new JRadioButton("Z");
			_jrbZ.setForeground(ASColor.GREEN.darker().darker());
			_jrbZ.addActionListener(_ctrGUI.listenerUpdateCircularAnimationProperties);
			
			buttonGroup = new ButtonGroup();
			buttonGroup.append(_jrbX);
			buttonGroup.append(_jrbY);
			buttonGroup.append(_jrbZ);
			
			centerPanel.append(_jrbX);
			centerPanel.append(_jrbY);
			centerPanel.append(_jrbZ);			
			
			return centerPanel;
		}
		
		private function buildLine2():JPanel
		{
			var southPanel:JPanel;
			var jlRotationSpeed:JLabel;
			var jlRotationUnit:JLabel;
			
			southPanel = new JPanel(new FlowLayout(FlowLayout.LEFT));
			
			jlRotationSpeed = new JLabel("Rotation period: ");
			_jtfRotationPeriod = new JTextField("10", 5);
			_jtfRotationPeriod.addEventListener(KeyboardEvent.KEY_UP, _ctrGUI.filterValidStrictPositiveCharFromTextField);
			_jtfRotationPeriod.addActionListener(_ctrGUI.listenerUpdateCircularAnimationProperties);
			
			jlRotationUnit = new JLabel("seconds");
			
			southPanel.append(jlRotationSpeed);
			southPanel.append(_jtfRotationPeriod);			
			southPanel.append(jlRotationUnit);
			
			return southPanel;
		}
		
		public function buildLine3():JPanel
		{
			var panelLine4:JPanel;
			var jlRotationRadius:JLabel;
			
			panelLine4 = new JPanel(new FlowLayout(FlowLayout.LEFT));
			
			jlRotationRadius = new JLabel("Rotation radius a: ");
			_jtfRotationRadiusA = new JTextField("0", 5);
			_jtfRotationRadiusA.addEventListener(KeyboardEvent.KEY_UP, _ctrGUI.filterValidStrictPositiveCharFromTextField);
			_jtfRotationRadiusA.addActionListener(function(e:Event):void
			{
				if (_jcbRadiusBCloneRadiusA.isSelected())
				{
					_jtfRotationRadiusB.setText(_jtfRotationRadiusA.getText());
				}
			});
			_jtfRotationRadiusA.addActionListener(_ctrGUI.listenerUpdateCircularAnimationProperties);
			
			
			
			panelLine4.append(jlRotationRadius);
			panelLine4.append(_jtfRotationRadiusA);
			
			return panelLine4;			
		}
		
		public function buildLine4():JPanel
		{
			var panelLine5:JPanel;
			var jlRotationRadius:JLabel;
			
			panelLine5 = new JPanel(new FlowLayout(FlowLayout.LEFT));
			
			jlRotationRadius = new JLabel("Rotation radius b: ");
			_jtfRotationRadiusB = new JTextField("0", 5);
			_jtfRotationRadiusB.addEventListener(KeyboardEvent.KEY_UP, _ctrGUI.filterValidStrictPositiveCharFromTextField);
			_jtfRotationRadiusB.addActionListener(_ctrGUI.listenerUpdateCircularAnimationProperties);
			
			_jcbRadiusBCloneRadiusA = new JCheckBox("Clone");
			_jcbRadiusBCloneRadiusA.setToolTipText("Clone 'radius a' value.\nUseful for circular animation");
			_jcbRadiusBCloneRadiusA.addSelectionListener(function(e:Event):void
			{
				if (_jcbRadiusBCloneRadiusA.isSelected())
				{
					_jtfRotationRadiusB.setText(_jtfRotationRadiusA.getText());
					_jtfRotationRadiusB.setEnabled(false);					
				}
				else
				{
					_jtfRotationRadiusB.setEnabled(true);
				}
			});
			
			panelLine5.append(jlRotationRadius);
			panelLine5.append(_jtfRotationRadiusB);
			panelLine5.append(_jcbRadiusBCloneRadiusA);
			
			return panelLine5;			
		}
		
		
		public function buildLine5():JPanel
		{
			var jp6:JPanel = new JPanel(new FlowLayout(FlowLayout.LEFT));
				
			_jcbReverseRotation = new JCheckBox("Reverse rotation");
			_jcbReverseRotation.addActionListener(function():void
			{
				_ctrGUI.listenerUpdateCircularAnimationProperties(null);	
			});
			jp6.append(_jcbReverseRotation);
			
			return jp6;
		}
		
		public function getJTFRotationPeriod():JTextField
		{
			return _jtfRotationPeriod;
		}
		
		public function getAnimationRotationAxis():uint
		{
			if (_jrbX.isSelected())
			{
				return ViewCircularAnimationScene.X_ROTATION_AXIS;
			}
			else if (_jrbY.isSelected())
			{
				return ViewCircularAnimationScene.Y_ROTATION_AXIS;
			}
			else
			{
				return ViewCircularAnimationScene.Z_ROTATION_AXIS;
			}
		}
		
		public function getJTFRotationRadiusA():JTextField
		{
			return _jtfRotationRadiusA;
		}
		
		public function getJTFRotationRadiusB():JTextField
		{
			return _jtfRotationRadiusB;
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
		
		public function setAnimationRotationAxis(rotationAxis:uint):void
		{
			if (rotationAxis == ViewCircularAnimationScene.X_ROTATION_AXIS)
			{
				_jrbX.setSelected(true);
			}
			else if (rotationAxis == ViewCircularAnimationScene.Y_ROTATION_AXIS)
			{
				_jrbY.setSelected(true);
			}
			else
			{
				_jrbZ.setSelected(true);
			}
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
		
		public function getJCBRadiusBCloneRadiusA():JCheckBox
		{
			return _jcbRadiusBCloneRadiusA;
		}		
	}
}