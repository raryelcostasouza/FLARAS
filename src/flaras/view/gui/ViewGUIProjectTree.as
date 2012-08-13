package flaras.view.gui
{
	import flaras.controller.*;
	import flaras.model.point.*;
	import flaras.model.scene.FlarasScene;
	import flash.events.*;
	import org.aswing.*;
	import org.aswing.geom.*;
	import org.aswing.tree.*;
	
	public class ViewGUIProjectTree extends JPanel
	{
		private var _tree:JTree;
		private var _root:DefaultMutableTreeNode;
		
		private var _ctrGUI:CtrGUI;
		private var _gui:GraphicsUserInterface;
		
		public function ViewGUIProjectTree(pCtrGUI:CtrGUI, pGUI:GraphicsUserInterface)
		{
			var root:DefaultMutableTreeNode;
			var jsp:JScrollPane;
			super();
			
			_ctrGUI = pCtrGUI;
			_gui = pGUI;
			
			_root = new DefaultMutableTreeNode("Ref. Marker");
			_tree = new JTree(new DefaultTreeModel(_root));
			_tree.setExpandsSelectedPaths(true);
			_tree.getSelectionModel().setSelectionMode(DefaultTreeSelectionModel.SINGLE_TREE_SELECTION);
			_tree.addSelectionListener(onSelection);
			
			jsp = new JScrollPane(_tree, JScrollPane.SCROLLBAR_ALWAYS, JScrollPane.SCROLLBAR_ALWAYS);
			jsp.setPreferredSize(new IntDimension(208, 204));
			append(jsp);
		}
		
		public function addPoint():void
		{
			var pointNode:DefaultMutableTreeNode;
			
			pointNode = new DefaultMutableTreeNode("Point " + (_root.getChildCount() + 1) + ": ");
			
			_root.insert(pointNode, _root.getChildCount());
			_tree.updateUI();
		}
		
		public function removePoint(pointID:uint):void
		{
			_root.removeAt(pointID);
			_tree.setSelectionPath(new TreePath([_root]));
			renumberPointLabelPrefix();
			_tree.updateUI();
		}
		
		private function renumberPointLabelPrefix():void
		{
			var node:DefaultMutableTreeNode;
			var userLabel:String;
			var newPrefix:String;
			
			for (var i:uint = 0; i < _root.getChildCount(); i++)
			{
				node = DefaultMutableTreeNode(_root.getChildAt(i));
				userLabel = getLabelSufix(String(node.getUserObject()));
				
				newPrefix = "Point " + (i + 1) + ":";
				node.setUserObject(newPrefix + userLabel);
			}
		}
		
		public function addScene(pointID:uint):void
		{
			var sceneNode:DefaultMutableTreeNode;
			var pointNode:DefaultMutableTreeNode;
			
			pointNode = DefaultMutableTreeNode(_root.getChildAt(pointID));
			sceneNode = new DefaultMutableTreeNode("Scene " + (pointNode.getChildCount() + 1) + ": ");
			
			pointNode.insert(sceneNode, pointNode.getChildCount());
			_tree.updateUI();
		}
		
		public function removeScene(pointID:uint, sceneID:uint):void
		{
			var pointNode:DefaultMutableTreeNode;
			
			pointNode = DefaultMutableTreeNode(_root.getChildAt(pointID));
			pointNode.removeAt(sceneID);
			selectPoint(pointID);
			renumberSceneLabelPrefix(pointID);
			_tree.updateUI();
		}
		
		private function renumberSceneLabelPrefix(pointID:uint):void
		{
			var pointNode:DefaultMutableTreeNode;
			var sceneNode:DefaultMutableTreeNode;
			var userLabel:String;
			var newPrefix:String;
			
			pointNode = DefaultMutableTreeNode(_root.getChildAt(pointID));
			
			for (var i:uint = 0; i < pointNode.getChildCount(); i++)
			{
				sceneNode = DefaultMutableTreeNode(pointNode.getChildAt(i));
				userLabel = getLabelSufix(String(sceneNode.getUserObject()));
				
				newPrefix = "Scene " + (i + 1) + ":";
				sceneNode.setUserObject(newPrefix + userLabel);
			}
		}
		
		public function updatePointLabel(pNewLabel:String):void
		{
			var node:DefaultMutableTreeNode;
			var index:uint;
			
			node = DefaultMutableTreeNode(_tree.getLastSelectedPathComponent());
			index = node.getParent().getIndex(node) + 1;
			
			node.setUserObject("Point " + index + ": " + pNewLabel);
			_tree.updateUI();
		}
		
		public function updateSceneLabel(pNewLabel:String):void
		{
			var selectedNode:DefaultMutableTreeNode;
			var index:uint;
			
			selectedNode = DefaultMutableTreeNode(_tree.getLastSelectedPathComponent());
			index = selectedNode.getParent().getIndex(selectedNode) + 1;
			
			selectedNode.setUserObject("Scene " + index + ": " + pNewLabel);
			_tree.updateUI();
		}
		
		public function rebuildPointBranch(indexPoint:uint, pListOfLabels:Vector.<String>):void
		{
			var sceneNode:DefaultMutableTreeNode;
			var pointNode:DefaultMutableTreeNode;
			
			pointNode = DefaultMutableTreeNode(_root.getChildAt(indexPoint));
			for (var i:uint = 0; i < pointNode.getChildCount(); i++)
			{
				sceneNode = DefaultMutableTreeNode(pointNode.getChildAt(i));
				sceneNode.setUserObject("Scene " + (i + 1) + ": " + pListOfLabels[i])				
			}
			
			_tree.updateUI();
		}
		
		public function onSelection(e:Event):void
		{
			var node:DefaultMutableTreeNode;
			var pointNode:DefaultMutableTreeNode;
			var nodeName:String;
			
			var prefixLabel:String;
			
			node = DefaultMutableTreeNode(_tree.getLastSelectedPathComponent());
			if (node != null)
			{
				nodeName = String(node.getUserObject());
				
				if (nodeName.indexOf("Ref. Marker") != -1)
				{
					_gui.showMarkerPanel();
				}
				else
				{
					prefixLabel = getLabelPrefix(nodeName);
					
					if (prefixLabel.indexOf("Point") != -1)
					{
						_gui.showPointPanel();
						_ctrGUI.actionPointSelected();
					}
					else
					{
						_gui.showScenePanel();
						_ctrGUI.actionSceneSelected();
					}
				}
			}		
		}
		
		public function getCurrentSelectedPoint():uint
		{
			var selectedNode:DefaultMutableTreeNode;
			var pointNode:DefaultMutableTreeNode;
			var prefixLabel:String;
			
			selectedNode = DefaultMutableTreeNode(_tree.getLastSelectedPathComponent());
			
			prefixLabel = getLabelPrefix(String(selectedNode.getUserObject()));
			
			//point selected
			if (prefixLabel.indexOf("Point") != -1)
			{
				pointNode = selectedNode;
			}
			//scene selected
			else
			{
				pointNode = DefaultMutableTreeNode(selectedNode.getParent());
			}
			
			return pointNode.getParent().getIndex(pointNode);
		}
		
		public function getCurrentSelectedScene():uint
		{
			var selectedNode:DefaultMutableTreeNode;
			
			selectedNode = DefaultMutableTreeNode(_tree.getLastSelectedPathComponent());
			
			return selectedNode.getParent().getIndex(selectedNode);
		}
		
		private function getLabelPrefix(label:String):String
		{
			var indexToken:uint;
			
			indexToken = label.indexOf(":");
			return label.slice(0, indexToken);
		}
		
		private function getLabelSufix(label:String):String
		{
			var indexToken:uint;
			
			indexToken = label.indexOf(":");
			return label.slice(indexToken + 1, label.length);
		}
		
		public function isPointSelected():Boolean
		{
			var selectedNode:DefaultMutableTreeNode;
			var label:String;
			var indexToken:uint;
			var prefixLabel:String;
			
			selectedNode = DefaultMutableTreeNode(_tree.getLastSelectedPathComponent());
			label = String(selectedNode.getUserObject());
			
			indexToken = label.indexOf(":");
			if (indexToken != -1)
			{
				prefixLabel = label.slice(0, indexToken);
				if (prefixLabel.indexOf("Point") != -1)
				{
					return true;
				}
				else
				{
					return false;
				}
			}
			else
			{
				return false;
			}
		}
		
		public function selectPoint(indexPoint:uint):void
		{
			var pointNode:DefaultMutableTreeNode;
			
			pointNode = DefaultMutableTreeNode(_root.getChildAt(indexPoint));
			_tree.setSelectionPath(new TreePath([_root, pointNode]));
		}
		
		public function selectScene(indexPoint:uint, indexScene:uint):void
		{
			var pointNode:DefaultMutableTreeNode;
			var sceneNode:DefaultMutableTreeNode;
			
			pointNode = DefaultMutableTreeNode(_root.getChildAt(indexPoint));
			sceneNode = DefaultMutableTreeNode(pointNode.getChildAt(indexScene));
			
			_tree.setSelectionPath(new TreePath([_root, pointNode, sceneNode]));
		}
		
		public function resetTree():void
		{			
			_root.removeAllChildren();
			_tree.setSelectionPath(new TreePath([_root]))
			_tree.updateUI();
		}
		
		public function initTree(listOfPoints:Vector.<Point>):void 
		{
			var pointNode:DefaultMutableTreeNode;
			var sceneNode:DefaultMutableTreeNode;
			
			resetTree();
			trace("NPoints:  " + listOfPoints.length);
			for each (var p:Point in listOfPoints) 
			{
				pointNode = new DefaultMutableTreeNode("Point " + (_root.getChildCount() + 1) +": " + p.getLabel());
				_root.insert(pointNode, _root.getChildCount());
				trace("NScenes:  " + p.getListOfFlarasScenes().length);
				for each (var scene:FlarasScene in p.getListOfFlarasScenes()) 
				{
					sceneNode = new DefaultMutableTreeNode("Scene " + (pointNode.getChildCount() + 1) + ": " + scene.getLabel())
					pointNode.insert(sceneNode, pointNode.getChildCount());
				}
			}
			_tree.updateUI();
		}
	}
}