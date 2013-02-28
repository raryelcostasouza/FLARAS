package flaras.view.gui 
{
	import flaras.controller.*;
	import flash.events.KeyboardEvent;
	import org.aswing.*;
	import org.aswing.border.*;
	import org.aswing.ext.*;
	import org.papervision3d.core.math.Number3D;
	public class ViewWindowP2PAnimation extends JFrame
	{
		private var _ctrGUI:CtrGUI;
		
		private var _jtfStartX:JTextField;
		private var _jtfStartY:JTextField;
		private var _jtfStartZ:JTextField;
		
		private var _jtfDestX:JTextField;
		private var _jtfDestY:JTextField;
		private var _jtfDestZ:JTextField;
		
		private var _jtfTime:JTextField;
		private var _jcbLoop:JCheckBox;
		
		public function ViewWindowP2PAnimation(pCtrGUI:CtrGUI) 
		{
			var mainPanel:JPanel;
			super(null, "Point to point animation", true);
			
			_ctrGUI = pCtrGUI;
			setDefaultCloseOperation(JFrame.HIDE_ON_CLOSE);
			
			mainPanel = new JPanel(new BorderLayout());
			mainPanel.append(buildMainPanelForm(), BorderLayout.CENTER);
			
			setContentPane(mainPanel);
			
			pack();
			setResizable(false);
			setLocationXY(320 - getWidth()/2, 240 - getHeight()/2);
			
		}
		
		private function buildMainPanelForm():Form
		{
			var objForm:Form;
			
			objForm = new Form();
			objForm.addRow(buildLine1());
			objForm.addRow(buildLine2());
			objForm.addRow(buildLine3());
			objForm.addRow(buildLine4());			
			
			return objForm;
		}
		
		private function buildLine1():JPanel
		{
			var jpLine:JPanel;
			var jlStartX:JLabel;
			var jlStartY:JLabel;
			var jlStartZ:JLabel;
			
			jpLine = new JPanel(new FlowLayout(FlowLayout.CENTER));
			jpLine.setBorder(new TitledBorder(null, "Start point position", TitledBorder.TOP, TitledBorder.LEFT));
			
			_jtfStartX = new JTextField("", 4);
			_jtfStartY = new JTextField("", 4);
			_jtfStartZ = new JTextField("", 4);
			
			_jtfStartX.addEventListener(KeyboardEvent.KEY_UP, _ctrGUI.filterValidCharFromTextField);
			_jtfStartY.addEventListener(KeyboardEvent.KEY_UP, _ctrGUI.filterValidCharFromTextField);
			_jtfStartZ.addEventListener(KeyboardEvent.KEY_UP, _ctrGUI.filterValidCharFromTextField);
			
			_jtfStartX.addActionListener(_ctrGUI.listenerUpdateP2PAnimationProperties);
			_jtfStartY.addActionListener(_ctrGUI.listenerUpdateP2PAnimationProperties);
			_jtfStartZ.addActionListener(_ctrGUI.listenerUpdateP2PAnimationProperties);
			
			jlStartX = new JLabel("X");
			jlStartY = new JLabel("Y");
			jlStartZ = new JLabel("Z");
			
			jlStartX.setForeground(ASColor.RED);
			jlStartY.setForeground(ASColor.BLUE);
			jlStartZ.setForeground(ASColor.GREEN.darker());
			
			jpLine.append(jlStartX);
			jpLine.append(_jtfStartX);
			
			jpLine.append(jlStartY);
			jpLine.append(_jtfStartY);
			
			jpLine.append(jlStartZ);
			jpLine.append(_jtfStartZ);
			
			return jpLine;
		}
		
		private function buildLine2():JPanel
		{
			var jpLine:JPanel;
			
			var jlDestX:JLabel;
			var jlDestY:JLabel;
			var jlDestZ:JLabel;
			
			jpLine = new JPanel(new FlowLayout(FlowLayout.CENTER));
			jpLine.setBorder(new TitledBorder(null, "Destination point position", TitledBorder.TOP, TitledBorder.LEFT));			
			
			_jtfDestX = new JTextField("", 4);
			_jtfDestY = new JTextField("", 4);
			_jtfDestZ = new JTextField("", 4);
			
			_jtfDestX.addEventListener(KeyboardEvent.KEY_UP, _ctrGUI.filterValidCharFromTextField);
			_jtfDestY.addEventListener(KeyboardEvent.KEY_UP, _ctrGUI.filterValidCharFromTextField);
			_jtfDestZ.addEventListener(KeyboardEvent.KEY_UP, _ctrGUI.filterValidCharFromTextField);
			
			_jtfDestX.addActionListener(_ctrGUI.listenerUpdateP2PAnimationProperties);
			_jtfDestY.addActionListener(_ctrGUI.listenerUpdateP2PAnimationProperties);
			_jtfDestZ.addActionListener(_ctrGUI.listenerUpdateP2PAnimationProperties);
			
			jlDestX = new JLabel("X");
			jlDestY = new JLabel("Y");
			jlDestZ = new JLabel("Z");
			
			jlDestX.setForeground(ASColor.RED);
			jlDestY.setForeground(ASColor.BLUE);
			jlDestZ.setForeground(ASColor.GREEN.darker());
			
			jpLine.append(jlDestX);
			jpLine.append(_jtfDestX);
			
			jpLine.append(jlDestY);
			jpLine.append(_jtfDestY);
			
			jpLine.append(jlDestZ);
			jpLine.append(_jtfDestZ);
			
			return jpLine;
		}
		
		private function buildLine3():JPanel
		{
			var jpLine:JPanel;
			var jlTime:JLabel;
			var jlSeconds:JLabel;
	
			jpLine = new JPanel(new FlowLayout(FlowLayout.CENTER));
			
			jlTime = new JLabel("Time");
			_jtfTime = new JTextField("", 4);
			jlSeconds = new JLabel("seconds");
			
			_jtfTime.addEventListener(KeyboardEvent.KEY_UP, _ctrGUI.filterValidStrictPositiveCharFromTextField);
			
			jpLine.append(jlTime);
			jpLine.append(_jtfTime);
			jpLine.append(jlSeconds);
			
			return jpLine;
		}
		
		private function buildLine4():JPanel
		{
			var jpLine:JPanel;
			
			jpLine = new JPanel(new FlowLayout(FlowLayout.CENTER));
			
			_jcbLoop = new JCheckBox("Loop?")
			jpLine.append(_jcbLoop);

			_jcbLoop.addSelectionListener(_ctrGUI.listenerUpdateP2PAnimationProperties);
			
			return jpLine;
		}
		
		public function cleanFields():void
		{
			_jtfStartX.setText("0");
			_jtfStartY.setText("0");
			_jtfStartZ.setText("0");
			
			_jtfDestX.setText("0");
			_jtfDestY.setText("0");
			_jtfDestZ.setText("0");
			
			_jtfTime.setText("10");
			_jcbLoop.setSelected(false);
		}
		
		public function getStartPointPosition():Number3D
		{
			return new Number3D(Number(_jtfStartX.getText()), Number(_jtfStartY.getText()), Number(_jtfStartZ.getText()));
		}
		
		public function getDestPointPosition():Number3D
		{
			return new Number3D(Number(_jtfDestX.getText()), Number(_jtfDestY.getText()), Number(_jtfDestZ.getText()));
		}
		
		public function getTime():Number
		{
			return Number(_jtfTime.getText());
		}
		
		public function hasLoop():Boolean
		{
			return _jcbLoop.isSelected();
		}
		
		public function setStartPointPosition(pPosition:Number3D):void
		{
			_jtfStartX.setText(pPosition.x+"");
			_jtfStartY.setText(pPosition.y+"");
			_jtfStartZ.setText(pPosition.z+"");
		}
		
		public function setDestPointPosition(pPosition:Number3D):void
		{
			_jtfDestX.setText(pPosition.x+"");
			_jtfDestX.setText(pPosition.y+"");
			_jtfDestX.setText(pPosition.z+"");
		}
		
		public function setLoop(hasLoop:Boolean):void
		{
			_jcbLoop.setSelected(hasLoop);
		}
		
		public function getJTFStartX():JTextField
		{
			return _jtfStartX;
		}
		
		public function getJTFStartY():JTextField
		{
			return _jtfStartY;
		}
		
		public function getJTFStartZ():JTextField
		{
			return _jtfStartZ;
		}
		
		public function getJTFDestX():JTextField
		{
			return _jtfDestX;
		}
		
		public function getJTFDestY():JTextField
		{
			return _jtfDestY;
		}
		
		public function getJTFDestZ():JTextField
		{
			return _jtfDestZ;
		}
		
		public function getJTFTime():JTextField
		{
			return _jtfTime;
		}		
	}
}