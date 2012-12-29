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
	import flash.display.LoaderInfo;
	import flash.events.*;
	import org.aswing.*;
	import org.aswing.border.*;
	import org.aswing.geom.*;
	/**
	 * ...
	 * @author Raryel Costa Souza
	 */
	public class ViewGUIScenePanel extends JTabbedPane
	{
		private var _ctrGUI:CtrGUI;
		
		private var _jrb3DObj:JRadioButton;
		private	var _jrbTexture:JRadioButton;
		private var _jrbVideo:JRadioButton;
		
		private var _tabType:JPanel;
		
		private var _3DObjPanel:JPanel;
		private var _jtf3DObjPath:JTextField;
		private var _jbLoad3DObj:JButton;
		
		private var _texturePanel:JPanel;
		private var _jtfTexturePath:JTextField;
		private var _jbLoadTexture:JButton;
		private var _jtfTextureWidth:JTextField;
		private var _jtfTextureHeight:JTextField;
		
		private var _videoPanel:JPanel;
		private var _jtfVideoPath:JTextField;
		private var _jbLoadVideo:JButton;
		private var _jtfVideoWidth:JTextField;
		private var _jtfVideoHeight:JTextField;
		private var _jcbVideoRepeat:JCheckBox;		
		
		private var _jtfSceneLabel:JTextField;
		private var _jtfSceneTrX:JTextField;
		private var _jtfSceneTrY:JTextField;
		private var _jtfSceneTrZ:JTextField;
		
		private var _jtfSceneRotX:JTextField;
		private var _jtfSceneRotY:JTextField;
		private var _jtfSceneRotZ:JTextField;
		
		private var _jtfSceneScX:JTextField;
		private var _jtfSceneScY:JTextField;
		private var _jtfSceneScZ:JTextField;
		
		private var _jcbAudio:JCheckBox;
		private var _jtfAudioPath:JTextField;
		private var _jbAddAudioFile:JButton;
		private var _jcbAudioRepeat:JCheckBox;	
		
		private var _animationPanel:AnimationPanel;
			
		public function ViewGUIScenePanel(pCtrGUI:CtrGUI) 
		{
			super();
			
			_ctrGUI = pCtrGUI;
			
			build3DObjSubPanel();
			buildTextureSubPanel();
			buildVideoSubPanel();
			
			appendTab(buildTabBasic(), "", new LoadIcon("icons/external/properties.png", 24, 24, true), "Properties");			
			appendTab(buildTabAudio(), "", new LoadIcon("icons/external/audio.png"), "Audio");
			appendTab(buildTabType(), "", new LoadIcon("icons/external/type.png"), "Scene type");
			appendTab(buildTabAnimation(), "", new LoadIcon("icons/external/animation.png"), "Animation");
			appendTab(buildTabOperations(), "", new LoadIcon("icons/external/operations.png", 24, 24, true), "Operations");
			
			setBackgroundDecorator(new SolidBackground(UIManager.getColor("window")));			
		}
		
		private function buildTabBasic():JPanel
		{
			var tabBasic:JPanel;
			var subPanelTr:JPanel;
			var subPanelRot:JPanel;
			var subPanelScale:JPanel;
			var subPanelLabel:JPanel;
						
			var jlTrX:JLabel = new JLabel("X");
			jlTrX.setForeground(ASColor.RED);
			var jlTrY:JLabel = new JLabel("Y");
			jlTrY.setForeground(ASColor.BLUE);
			var jlTrZ:JLabel = new JLabel("Z");
			jlTrZ.setForeground(ASColor.GREEN.darker());
			
			var jlRotX:JLabel = new JLabel("X");
			jlRotX.setForeground(ASColor.RED);
			var jlRotY:JLabel = new JLabel("Y");
			jlRotY.setForeground(ASColor.BLUE);
			var jlRotZ:JLabel = new JLabel("Z");
			jlRotZ.setForeground(ASColor.GREEN.darker());
			
			var jlScX:JLabel = new JLabel("X");
			jlScX.setForeground(ASColor.RED);
			var jlScY:JLabel = new JLabel("Y");
			jlScY.setForeground(ASColor.BLUE);
			var jlScZ:JLabel = new JLabel("Z");
			jlScZ.setForeground(ASColor.GREEN.darker());
			
			_jtfSceneTrX = new JTextField("", 4);
			_jtfSceneTrY = new JTextField("", 4);
			_jtfSceneTrZ = new JTextField("", 4);
			
			_jtfSceneTrX.addEventListener(KeyboardEvent.KEY_UP, _ctrGUI.filterValidCharFromTextField);
			_jtfSceneTrY.addEventListener(KeyboardEvent.KEY_UP, _ctrGUI.filterValidCharFromTextField);
			_jtfSceneTrZ.addEventListener(KeyboardEvent.KEY_UP, _ctrGUI.filterValidCharFromTextField);
			
			_jtfSceneTrX.addActionListener(_ctrGUI.listenerUpdateSceneTranslation);
			_jtfSceneTrY.addActionListener(_ctrGUI.listenerUpdateSceneTranslation);
			_jtfSceneTrZ.addActionListener(_ctrGUI.listenerUpdateSceneTranslation);
				
			_jtfSceneRotX = new JTextField("", 4);
			_jtfSceneRotY = new JTextField("", 4);
			_jtfSceneRotZ = new JTextField("", 4);
			
			_jtfSceneRotX.addEventListener(KeyboardEvent.KEY_UP, _ctrGUI.filterValidCharFromTextField);
			_jtfSceneRotY.addEventListener(KeyboardEvent.KEY_UP, _ctrGUI.filterValidCharFromTextField);
			_jtfSceneRotZ.addEventListener(KeyboardEvent.KEY_UP, _ctrGUI.filterValidCharFromTextField);
			
			_jtfSceneRotX.addActionListener(_ctrGUI.listenerUpdateSceneRotation);
			_jtfSceneRotY.addActionListener(_ctrGUI.listenerUpdateSceneRotation);
			_jtfSceneRotZ.addActionListener(_ctrGUI.listenerUpdateSceneRotation);
			
			_jtfSceneScX = new JTextField("", 4);
			_jtfSceneScY = new JTextField("", 4);
			_jtfSceneScZ = new JTextField("", 4);
			
			_jtfSceneScX.addEventListener(KeyboardEvent.KEY_UP, _ctrGUI.filterValidStrictPositiveCharFromTextField);
			_jtfSceneScY.addEventListener(KeyboardEvent.KEY_UP, _ctrGUI.filterValidStrictPositiveCharFromTextField);
			_jtfSceneScZ.addEventListener(KeyboardEvent.KEY_UP, _ctrGUI.filterValidStrictPositiveCharFromTextField);
			
			_jtfSceneScX.addActionListener(_ctrGUI.listenerUpdateSceneScale);
			_jtfSceneScY.addActionListener(_ctrGUI.listenerUpdateSceneScale);
			_jtfSceneScZ.addActionListener(_ctrGUI.listenerUpdateSceneScale);
			
			tabBasic = new JPanel(new FlowLayout(FlowLayout.CENTER));
						
			subPanelLabel = new JPanel(new FlowLayout(FlowLayout.CENTER));
			subPanelLabel.setBorder(new TitledBorder(null, "Scene label", TitledBorder.TOP, TitledBorder.LEFT));
			_jtfSceneLabel = new JTextField("", 20);
			_jtfSceneLabel.addActionListener(_ctrGUI.listenerUpdateSceneLabel);
			
			subPanelLabel.append(_jtfSceneLabel);
			tabBasic.append(subPanelLabel);			
			
			subPanelTr = new JPanel();
			subPanelTr.setBorder(new TitledBorder(null, "Translation", TitledBorder.TOP, TitledBorder.LEFT));
			subPanelTr.append(jlTrX);
			subPanelTr.append(_jtfSceneTrX);
			subPanelTr.append(jlTrY);
			subPanelTr.append(_jtfSceneTrY);
			subPanelTr.append(jlTrZ);
			subPanelTr.append(_jtfSceneTrZ);
			tabBasic.append(subPanelTr);
			
			subPanelRot = new JPanel();
			subPanelRot.setBorder(new TitledBorder(null, "Rotation", TitledBorder.TOP, TitledBorder.LEFT));
			subPanelRot.append(jlRotX);
			subPanelRot.append(_jtfSceneRotX);
			subPanelRot.append(jlRotY);
			subPanelRot.append(_jtfSceneRotY);
			subPanelRot.append(jlRotZ);
			subPanelRot.append(_jtfSceneRotZ);
			tabBasic.append(subPanelRot);
			
			subPanelScale = new JPanel();
			subPanelScale.setBorder(new TitledBorder(null, "Scale", TitledBorder.TOP, TitledBorder.LEFT));
			subPanelScale.append(jlScX);
			subPanelScale.append(_jtfSceneScX);
			subPanelScale.append(jlScY);
			subPanelScale.append(_jtfSceneScY);
			subPanelScale.append(jlScZ);
			subPanelScale.append(_jtfSceneScZ);
			tabBasic.append(subPanelScale);
			
			return tabBasic;
		}
		
		private function buildTabAudio():JPanel
		{
			var tabAudio:JPanel;
			var subPanel:JPanel;
			var subPanel2:JPanel;
			
			tabAudio = new JPanel(new BorderLayout());
			
			subPanel2 = new JPanel(new FlowLayout(FlowLayout.LEFT));
			_jcbAudio = new JCheckBox("Audio");	
			_jcbAudio.addActionListener(_ctrGUI.listenerAudioSelected);
			
			subPanel2.append(_jcbAudio);
			
			subPanel = new JPanel(new FlowLayout());
			_jtfAudioPath = new JTextField("", 20);
			_jtfAudioPath.setEditable(false);
			_jbAddAudioFile = new JButton("...");
			_jbAddAudioFile.addActionListener(_ctrGUI.listenerAddAudio);
			
			_jcbAudioRepeat = new JCheckBox("Repeat");
			_jcbAudioRepeat.addActionListener(_ctrGUI.listenerUpdateAudioRepeat);
			
			subPanel.append(_jtfAudioPath);
			subPanel.append(_jbAddAudioFile);
			subPanel.append(_jcbAudioRepeat);
			
			tabAudio.append(subPanel2, BorderLayout.NORTH);			
			tabAudio.append(subPanel, BorderLayout.CENTER);
		
			return tabAudio;
		}
		
		private function buildTabType():JPanel
		{
			var bg:ButtonGroup;
			var topPanel:JPanel;
			
			_tabType = new JPanel(new BorderLayout());
			
			topPanel = new JPanel();
			topPanel.setBorder(new TitledBorder(null, "Scene type", TitledBorder.TOP, TitledBorder.LEFT));
			
			_jrb3DObj = new JRadioButton("3D Object");
			_jrb3DObj.setSelected(true);
			_jrbTexture = new JRadioButton("Texture");
			_jrbVideo = new JRadioButton("Video");
			
			_jrb3DObj.addSelectionListener(_ctrGUI.listenerRadioSelect3DObj);
			_jrbTexture.addSelectionListener(_ctrGUI.listenerRadioSelectTexture);
			_jrbVideo.addSelectionListener(_ctrGUI.listenerRadioSelectVideo);
			
			bg = new ButtonGroup();
			bg.append(_jrb3DObj);
			bg.append(_jrbTexture);
			bg.append(_jrbVideo);
			
			topPanel.append(_jrb3DObj);
			topPanel.append(_jrbTexture);
			topPanel.append(_jrbVideo);
			
			_tabType.append(topPanel, BorderLayout.NORTH);
			_tabType.append(_3DObjPanel, BorderLayout.CENTER);
			
			return _tabType;
		}
		
		private function buildTabAnimation():AnimationPanel
		{
			_animationPanel = new AnimationPanel(_ctrGUI);
			return _animationPanel;
		}
		
		private function buildTabOperations():JPanel
		{
			var tabOperations:JPanel;
			var jbDeleteScene:JButton;
			var jbSwapScenePosition:JButton;
			var jbClone:JButton;
			
			tabOperations = new JPanel(new FlowLayout(FlowLayout.CENTER));
			
			jbSwapScenePosition = new JButton("Change scene position", new LoadIcon("icons/external/swap.png"));
			jbDeleteScene = new JButton("Delete Scene", new LoadIcon("icons/external/delete.png"));
			jbClone = new JButton("Clone Scene", new LoadIcon("icons/external/clone.png"));
			jbClone.setPreferredWidth(167);
			jbDeleteScene.setPreferredWidth(167);
			
			jbDeleteScene.addActionListener(_ctrGUI.listenerRemoveScene);
			jbSwapScenePosition.addActionListener(_ctrGUI.listenerSwapScene);
			jbClone.addActionListener(_ctrGUI.listenerCloneScene);
			
			tabOperations.append(jbSwapScenePosition);			
			tabOperations.append(jbDeleteScene);
			tabOperations.append(jbClone);
			
			return tabOperations;
		}
		
		private function build3DObjSubPanel():void
		{
			_3DObjPanel = new JPanel();
			_3DObjPanel.setBorder(new TitledBorder(null, "3D Object Properties", TitledBorder.TOP, TitledBorder.LEFT));
			
			_jtf3DObjPath = new JTextField("", 20);
			_jtf3DObjPath.setEditable(false);
			_jbLoad3DObj = new JButton("...");
			_jbLoad3DObj.addActionListener(_ctrGUI.listenerAddObj3DScene);
			
			_3DObjPanel.append(_jtf3DObjPath);
			_3DObjPanel.append(_jbLoad3DObj);			
		}
		
		private function buildTextureSubPanel():void
		{
			var jlWidth:JLabel;
			var jlHeight:JLabel;
			
			_texturePanel = new JPanel();
			_texturePanel.setBorder(new TitledBorder(null, "Texture Properties", TitledBorder.TOP, TitledBorder.LEFT));
			
			jlWidth = new JLabel("Width:");
			jlHeight = new JLabel("Height:");
			
			_jtfTexturePath = new JTextField("", 20);
			_jtfTexturePath.setEditable(false);
			_jbLoadTexture = new JButton("...");
			_jbLoadTexture.addActionListener(_ctrGUI.listenerAddTextureScene);
			
			_jtfTextureWidth = new JTextField("", 4);
			_jtfTextureHeight = new JTextField("", 4);
			
			_jtfTextureWidth.addEventListener(KeyboardEvent.KEY_UP, _ctrGUI.filterValidStrictPositiveCharFromTextField);
			_jtfTextureHeight.addEventListener(KeyboardEvent.KEY_UP, _ctrGUI.filterValidStrictPositiveCharFromTextField);
			
			_jtfTextureWidth.addActionListener(_ctrGUI.listenerUpdateSceneTextureSize);
			_jtfTextureHeight.addActionListener(_ctrGUI.listenerUpdateSceneTextureSize);
			
			_texturePanel.append(_jtfTexturePath);
			_texturePanel.append(_jbLoadTexture);
			_texturePanel.append(jlWidth);
			_texturePanel.append(_jtfTextureWidth);
			_texturePanel.append(jlHeight);
			_texturePanel.append(_jtfTextureHeight);			
		}
		
		private function buildVideoSubPanel():void
		{
			var jlWidth:JLabel;
			var jlHeight:JLabel;
			
			_videoPanel = new JPanel();
			_videoPanel.setBorder(new TitledBorder(null, "Video Properties", TitledBorder.TOP, TitledBorder.LEFT));
			
			jlWidth = new JLabel("Width:");
			jlHeight = new JLabel("Height:");
			
			_jtfVideoPath = new JTextField("", 20);
			_jtfVideoPath.setEditable(false);
			_jbLoadVideo = new JButton("...");
			_jbLoadVideo.addActionListener(_ctrGUI.listenerAddVideoScene);
			
			_jtfVideoWidth = new JTextField("", 4);
			_jtfVideoHeight = new JTextField("", 4);
			
			_jcbVideoRepeat = new JCheckBox("Repeat");
			
			_jtfVideoWidth.addEventListener(KeyboardEvent.KEY_UP, _ctrGUI.filterValidStrictPositiveCharFromTextField);
			_jtfVideoHeight.addEventListener(KeyboardEvent.KEY_UP, _ctrGUI.filterValidStrictPositiveCharFromTextField);
			
			_jtfVideoWidth.addActionListener(_ctrGUI.listenerUpdateSceneVideoSize);
			_jtfVideoHeight.addActionListener(_ctrGUI.listenerUpdateSceneVideoSize);
			_jcbVideoRepeat.addActionListener(_ctrGUI.listenerUpdateVideoRepeat);
			
			_videoPanel.append(_jtfVideoPath);
			_videoPanel.append(_jbLoadVideo);
			_videoPanel.append(jlWidth);
			_videoPanel.append(_jtfVideoWidth);
			_videoPanel.append(jlHeight);
			_videoPanel.append(_jtfVideoHeight);
			_videoPanel.append(_jcbVideoRepeat);
		}
		
		public function getJTFSceneLabel():JTextField 
		{
			return _jtfSceneLabel;
		}
		
		public function getJTFSceneTrX():JTextField 
		{
			return _jtfSceneTrX;
		}
		
		public function getJTFSceneTrY():JTextField 
		{
			return _jtfSceneTrY;
		}
		
		public function getJTFSceneTrZ():JTextField 
		{
			return _jtfSceneTrZ;
		}
		
		public function getJTFSceneRotX():JTextField 
		{
			return _jtfSceneRotX;
		}
		
		public function getJTFSceneRotY():JTextField 
		{
			return _jtfSceneRotY;
		}
		
		public function getJTFSceneRotZ():JTextField 
		{
			return _jtfSceneRotZ;
		}
		
		public function getJTFSceneScX():JTextField 
		{
			return _jtfSceneScX;
		}
		
		public function getJTFSceneScY():JTextField 
		{
			return _jtfSceneScY;
		}
		
		public function getJTFSceneScZ():JTextField 
		{
			return _jtfSceneScZ;
		}
		
		public function getJCBAudio():JCheckBox 
		{
			return _jcbAudio;
		}
		
		public function getJTFAudioPath():JTextField 
		{
			return _jtfAudioPath;
		}
		
		public function getJBAddAudioFile():JButton 
		{
			return _jbAddAudioFile;
		}
		
		public function getJCBAudioRepeat():JCheckBox 
		{
			return _jcbAudioRepeat;
		}
		
		public function get3DObjPanel():JPanel 
		{
			return _3DObjPanel;
		}
		
		public function getTexturePanel():JPanel 
		{
			return _texturePanel;
		}
		
		public function getVideoPanel():JPanel 
		{
			return _videoPanel;
		}
		
		public function getTabType():JPanel 
		{
			return _tabType;
		}
		
		public function getJRB3DObj():JRadioButton 
		{
			return _jrb3DObj;
		}
		
		public function getJRBTexture():JRadioButton 
		{
			return _jrbTexture;
		}
		
		public function getJRBVideo():JRadioButton 
		{
			return _jrbVideo;
		}
		
		public function getJTF3DObjPath():JTextField 
		{
			return _jtf3DObjPath;
		}
		
		public function getJTFTexturePath():JTextField 
		{
			return _jtfTexturePath;
		}
		
		public function getJTFTextureWidth():JTextField 
		{
			return _jtfTextureWidth;
		}
		
		public function getJTFTextureHeight():JTextField 
		{
			return _jtfTextureHeight;
		}
		
		public function getJTFVideoPath():JTextField 
		{
			return _jtfVideoPath;
		}
		
		public function getJTFVideoWidth():JTextField 
		{
			return _jtfVideoWidth;
		}
		
		public function getJTFVideoHeight():JTextField 
		{
			return _jtfVideoHeight;
		}
		
		public function getJCBVideoRepeat():JCheckBox 
		{
			return _jcbVideoRepeat;
		}	
		
		public function getAnimationPanel():AnimationPanel 
		{
			return _animationPanel;
		}
	}
}