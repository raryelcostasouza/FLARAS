package flaras.view.gui 
{
	import flaras.controller.*;
	import flash.events.*;
	import org.aswing.*;
	import org.aswing.border.*;
	import org.aswing.geom.*;

	public class ViewGUIPointPanel extends JTabbedPane
	{
		private var _jtfPointLabel:JTextField;
		private var _ctrGUI:CtrGUI;
		private var _jtfPointTrX:JTextField;
		private var _jtfPointTrY:JTextField;
		private var _jtfPointTrZ:JTextField;
		private var _jcbMovableScenes:JCheckBox;
			
		
		public function ViewGUIPointPanel(pCtrGUI:CtrGUI) 
		{
			super();
			
			_ctrGUI = pCtrGUI;
			
			appendTab(buildTabProperties(), "", new LoadIcon("icons/external/properties.png", 24, 24, true), "Properties");
			appendTab(buildTabOperations(), "", new LoadIcon("icons/external/operations.png", 24, 24, true), "Operations")
			
			setBackgroundDecorator(new SolidBackground(UIManager.getColor("window")));
		}
		
		private function buildTabProperties():JPanel
		{
			var tabProperties:JPanel;
			var subPanel:JPanel;
			var subPanel2:JPanel;
			var jlPointTrX:JLabel;
			var jlPointTrY:JLabel;
			var jlPointTrZ:JLabel;
			
			tabProperties = new JPanel(new FlowLayout(FlowLayout.CENTER));
			tabProperties.setPreferredSize(new IntDimension(214, 480));
			
			subPanel = new JPanel();
			subPanel.setBorder(new TitledBorder(null, "Point label", TitledBorder.TOP, TitledBorder.LEFT));
			_jtfPointLabel = new JTextField("", 20);
			_jtfPointLabel.addActionListener(_ctrGUI.listenerUpdatePointLabel);
			subPanel.append(_jtfPointLabel);
			
			tabProperties.append(subPanel);			
			
			subPanel2 = new JPanel();
			subPanel2.setBorder(new TitledBorder(null, "Translation", TitledBorder.TOP, TitledBorder.LEFT));
			jlPointTrX = new JLabel("X");
			jlPointTrX.setForeground(ASColor.RED);
			jlPointTrY = new JLabel("Y");
			jlPointTrY.setForeground(ASColor.BLUE);
			jlPointTrZ = new JLabel("Z");
			jlPointTrZ.setForeground(ASColor.GREEN.darker());
			
			_jtfPointTrX = new JTextField("", 4);
			_jtfPointTrY = new JTextField("", 4);
			_jtfPointTrZ = new JTextField("", 4);
			
			_jtfPointTrX.addEventListener(KeyboardEvent.KEY_UP, _ctrGUI.filterValidCharFromTextField);
			_jtfPointTrY.addEventListener(KeyboardEvent.KEY_UP, _ctrGUI.filterValidCharFromTextField);
			_jtfPointTrZ.addEventListener(KeyboardEvent.KEY_UP, _ctrGUI.filterValidCharFromTextField);
			
			_jtfPointTrX.addActionListener(_ctrGUI.listenerUpdatePointPosition);
			_jtfPointTrY.addActionListener(_ctrGUI.listenerUpdatePointPosition);
			_jtfPointTrZ.addActionListener(_ctrGUI.listenerUpdatePointPosition);
			
			subPanel2.append(jlPointTrX);
			subPanel2.append(_jtfPointTrX);
			subPanel2.append(jlPointTrY);
			subPanel2.append(_jtfPointTrY);
			subPanel2.append(jlPointTrZ);
			subPanel2.append(_jtfPointTrZ);
			
			tabProperties.append(subPanel2);
			
			_jcbMovableScenes = new JCheckBox("Enable move interaction for scenes");
			_jcbMovableScenes.addActionListener(_ctrGUI.listenerUpdateMoveInteractionForScenes);
			
			tabProperties.append(_jcbMovableScenes);
			
			return tabProperties;
		}
		
		private function buildTabOperations():JPanel
		{
			var tabOperations:JPanel;
			var jbRemPoint:JButton;
			var jbAdd3DObjScene:JButton;
			var jbAddTextureScene:JButton;
			var jbAddVideoScene:JButton;
			
			tabOperations = new JPanel(new FlowLayout(FlowLayout.CENTER));
			tabOperations.setPreferredSize(new IntDimension(214,480));
			
			jbAdd3DObjScene = new JButton("Add 3D Obj Scene", new LoadIcon("icons/external/obj3d.png", 48, 48));
			jbAddTextureScene = new JButton("Add Texture Scene", new LoadIcon("icons/external/texture.png", 48, 48));
			jbAddVideoScene = new JButton("Add Video Scene", new LoadIcon("icons/external/video.png", 48, 48));
			jbRemPoint = new JButton("Delete point", new LoadIcon("icons/external/delete.png", 48, 48));
			
			jbAdd3DObjScene.setPreferredWidth(150);
			jbAddVideoScene.setPreferredWidth(150);
			jbRemPoint.setPreferredWidth(150);
			
			jbAdd3DObjScene.addActionListener(_ctrGUI.listenerAddObj3DScene);
			jbAddTextureScene.addActionListener(_ctrGUI.listenerAddTextureScene);
			jbAddVideoScene.addActionListener(_ctrGUI.listenerAddVideoScene);
			jbRemPoint.addActionListener(_ctrGUI.listenerRemovePoint);
			
			tabOperations.append(jbAdd3DObjScene);			
			tabOperations.append(jbAddTextureScene);			
			tabOperations.append(jbAddVideoScene);			
			tabOperations.append(jbRemPoint);
			
			return tabOperations;
		}	
		
		public function getJTFPointLabel():JTextField
		{
			return _jtfPointLabel;
		}
		
		public function getJTFPointTrX():JTextField 
		{
			return _jtfPointTrX;
		}
		
		public function getJTFPointTrY():JTextField 
		{
			return _jtfPointTrY;
		}
		
		public function getJTFPointTrZ():JTextField 
		{
			return _jtfPointTrZ;
		}
		
		public function getJCBMoveInteractionForScenes():JCheckBox
		{
			return _jcbMovableScenes;
		}
	}

}