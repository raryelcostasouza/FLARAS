package flaras.view.gui 
{
	import flaras.controller.*;
	import org.aswing.*;
	import org.aswing.border.*;
	import org.aswing.geom.*;
	
	public class ViewGUIMarkerPanel extends JTabbedPane
	{
		private var _ctrGUI:CtrGUI;
		private var _jcbRefMarkerPersistence:JCheckBox;
		private var _jrbRefMarkerBaseSphere:JRadioButton; 
		private var _jrbRefMarkerBasePlane:JRadioButton;
		
		public function ViewGUIMarkerPanel(pCtrGUI:CtrGUI) 
		{
			super();
			
			_ctrGUI = pCtrGUI;
			
			appendTab(buildTabProperties(), "", new LoadIcon("icons/external/properties.png", 24, 24, true), "Properties");
			appendTab(buildTabOperations(), "", new LoadIcon("icons/external/operations.png", 24, 24, true), "Operations");
			
			setBackgroundDecorator(new SolidBackground(UIManager.getColor("window")));
		}
		
		private function buildTabProperties():JPanel
		{
			var subPanel:JPanel;
			var tabProperties:JPanel;
			var bg:ButtonGroup;
			
			tabProperties = new JPanel(new BorderLayout());
			tabProperties.setPreferredSize(new IntDimension(214, 480));
			
			_jcbRefMarkerPersistence = new JCheckBox("Base persistence");
			_jcbRefMarkerPersistence.addActionListener(_ctrGUI.listenerToggleRefMarkerPersistence);
			
			tabProperties.append(_jcbRefMarkerPersistence, BorderLayout.NORTH);
			
			subPanel = new JPanel(new FlowLayout(FlowLayout.CENTER));
			subPanel.setBorder(new TitledBorder(null, "Cover type", TitledBorder.TOP, TitledBorder.LEFT));
			
			_jrbRefMarkerBasePlane = new JRadioButton("Plane");
			_jrbRefMarkerBasePlane.addActionListener(_ctrGUI.listenerSetMarkerBaseTypePlane);
			_jrbRefMarkerBaseSphere = new JRadioButton("Sphere"); 
			_jrbRefMarkerBaseSphere.addActionListener(_ctrGUI.listenerSetMarkerBaseTypeSphere);
			
			subPanel.append(_jrbRefMarkerBasePlane);
			subPanel.append(_jrbRefMarkerBaseSphere);
			_jrbRefMarkerBasePlane.setSelected(true);
			
			bg = new ButtonGroup();
			bg.append(_jrbRefMarkerBasePlane);
			bg.append(_jrbRefMarkerBaseSphere);
			
			tabProperties.append(subPanel, BorderLayout.CENTER);		
			
			return tabProperties;
		}
		
		private function buildTabOperations():JPanel
		{
			var tabOperations:JPanel;
			var jbAddPoint:JButton;
			
			tabOperations = new JPanel(new FlowLayout(FlowLayout.CENTER));
			tabOperations.setPreferredSize(new IntDimension(214, 480));
			
			jbAddPoint = new JButton("Add new point", new LoadIcon("icons/external/add-point.png", 48, 48));
			jbAddPoint.addActionListener(_ctrGUI.listenerAddPoint);
			
			tabOperations.append(jbAddPoint);
			
			return tabOperations;
		}
		
		public function getJCBRefMarkerPersistence():JCheckBox 
		{
			return _jcbRefMarkerPersistence;
		}
		
		public function setJRBMarkerBaseType(pBaseType:uint):void
		{
			if (pBaseType == CtrMarker.REF_BASE_RECTANGLE_PLANE)
			{
				_jrbRefMarkerBasePlane.setSelected(true);
			}
			else
			{
				_jrbRefMarkerBaseSphere.setSelected(true);
			}
		}		
	}
}