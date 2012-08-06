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
	import flaras.userInterface.*;
	import flash.events.*;
	import org.aswing.*;
	import org.aswing.geom.IntDimension;
	
	public class PropertiesPanel extends JPanel
	{	
		private var ptList:JComboBox;
		private var btRemovePt:JButton;
		private var ptX:JTextField;
		private var ptY:JTextField;
		private var ptZ:JTextField;
		private var objList:JComboBox;
		private var btRemoveObj:JButton;
		private var btSwapObj:JButton;
		private var objTrX:JTextField;
		private var objTrY:JTextField;
		private var objTrZ:JTextField;
		private var objRtX:JTextField;
		private var objRtY:JTextField;
		private var objRtZ:JTextField;
		private var objScX:JTextField;
		private var objScY:JTextField;
		private var objScZ:JTextField;
		//Audio properties
		private var objAudioFilePath:JTextField;
		private var btnAudioLoad:JButton;
		private var objAudioRpt:JCheckBox;
		
		private var objAudioCheck:JCheckBox;
		private var obj3DRdBt:JRadioButton;
		private var videoRdBt:JRadioButton;
		private var textureRdBt:JRadioButton;
		private const jtfColumns:uint = 4;
		
		
		public function PropertiesPanel(pCtrGUI:CtrGUI) {
			super(new FlowLayout());
			setPreferredSize(new IntDimension(210, 470));
			
			append(new JLabel("Point"));
			//point properties
			append(ptList = new JComboBox());
			ptList.setPreferredWidth(100);
			ptList.setEditable(false);
			pCtrGUI.comboBoxContentsUpdate(ptList, pCtrGUI.getListOfPoints().length);
			ptList.addActionListener(pCtrGUI.pointSelected);
			append(btRemovePt = new JButton("x"));
			btRemovePt.addActionListener(pCtrGUI.removePoint);
			append(new JLabel("           "));
			append(new JLabel(" X "));
			append(ptX = new JTextField("", jtfColumns));
			//ptX.addActionListener(pCtrGUI.textUpdate);
			ptX.addActionListener(pCtrGUI.updatePointPosition);
			ptX.addEventListener(KeyboardEvent.KEY_UP, pCtrGUI.filterValidCharFromTextField);
			append(new JLabel(" Y "));
			append(ptY = new JTextField("", jtfColumns));
			//ptY.addActionListener(pCtrGUI.textUpdate);
			ptY.addActionListener(pCtrGUI.updatePointPosition);
			ptY.addEventListener(KeyboardEvent.KEY_UP, pCtrGUI.filterValidCharFromTextField);
			append(new JLabel(" Z "));
			append(ptZ = new JTextField("", jtfColumns));
			//ptZ.addActionListener(pCtrGUI.textUpdate);
			ptZ.addActionListener(pCtrGUI.updatePointPosition);
			ptZ.addEventListener(KeyboardEvent.KEY_UP, pCtrGUI.filterValidCharFromTextField);
			//object properties
			append(new JLabel("Scene"));
			append(objList = new JComboBox());
			objList.setPreferredWidth(100);
			objList.setEditable(false);
			objList.addActionListener(pCtrGUI.objectSelected);
			append(btRemoveObj = new JButton("x"));
			btRemoveObj.addActionListener(pCtrGUI.removeObject);
			append(btSwapObj = new JButton("@"));
			btSwapObj.addActionListener(pCtrGUI.swapObject);
			append(new JLabel("Translation                                           "));
			append(new JLabel(" X "));
			append(objTrX = new JTextField("", jtfColumns));
			//objTrX.addActionListener(pCtrGUI.textUpdate);
			objTrX.addActionListener(pCtrGUI.updateSceneTranslation);
			objTrX.addEventListener(KeyboardEvent.KEY_UP, pCtrGUI.filterValidCharFromTextField);
			append(new JLabel(" Y "));
			append(objTrY = new JTextField("", jtfColumns));
			//objTrY.addActionListener(pCtrGUI.textUpdate);
			objTrY.addActionListener(pCtrGUI.updateSceneTranslation);
			objTrY.addEventListener(KeyboardEvent.KEY_UP, pCtrGUI.filterValidCharFromTextField);
			append(new JLabel(" Z "));
			append(objTrZ = new JTextField("", jtfColumns));
			//objTrZ.addActionListener(pCtrGUI.textUpdate);
			objTrZ.addActionListener(pCtrGUI.updateSceneTranslation);
			objTrZ.addEventListener(KeyboardEvent.KEY_UP, pCtrGUI.filterValidCharFromTextField);
			append(new JLabel("Rotation                                                "));
			append(new JLabel(" X "));
			append(objRtX = new JTextField("", jtfColumns));
			//objRtX.addActionListener(pCtrGUI.textUpdate);
			objRtX.addActionListener(pCtrGUI.updateSceneRotation);
			objRtX.addEventListener(KeyboardEvent.KEY_UP, pCtrGUI.filterValidCharFromTextField);
			append(new JLabel(" Y "));
			append(objRtY = new JTextField("", jtfColumns));
			objRtY.addActionListener(pCtrGUI.updateSceneRotation);
			objRtY.addEventListener(KeyboardEvent.KEY_UP, pCtrGUI.filterValidCharFromTextField);
			append(new JLabel(" Z "));
			append(objRtZ = new JTextField("", jtfColumns));
			objRtZ.addActionListener(pCtrGUI.updateSceneRotation);
			objRtZ.addEventListener(KeyboardEvent.KEY_UP, pCtrGUI.filterValidCharFromTextField);
			append(new JLabel("Scale                                                    "));
			append(new JLabel(" X "));
			append(objScX = new JTextField("", jtfColumns));
			objScX.addActionListener(pCtrGUI.updateSceneScale);
			objScX.addEventListener(KeyboardEvent.KEY_UP, pCtrGUI.filterValidStrictPositiveCharFromTextField);
			append(new JLabel(" Y "));
			append(objScY = new JTextField("", jtfColumns));
			objScY.addActionListener(pCtrGUI.updateSceneScale);
			objScY.addEventListener(KeyboardEvent.KEY_UP, pCtrGUI.filterValidStrictPositiveCharFromTextField);
			append(new JLabel(" Z "));
			append(objScZ = new JTextField("", jtfColumns));
			objScZ.addActionListener(pCtrGUI.updateSceneScale);
			objScZ.addEventListener(KeyboardEvent.KEY_UP, pCtrGUI.filterValidStrictPositiveCharFromTextField);
			append(new JLabel(""));
			//object audio properties
			append(objAudioCheck = new JCheckBox("Has Audio?"));
			objAudioCheck.addActionListener(pCtrGUI.audioSelected);
			append(new JLabel("                                 "));
			append(new JLabel("URL"));
			append(objAudioFilePath = new JTextField("", 14));
			objAudioFilePath.setEditable(false);
			append(btnAudioLoad = new JButton("..."));
			btnAudioLoad.addActionListener(pCtrGUI.audioLoad);
			append(objAudioRpt = new JCheckBox("Repeat                                "));
			objAudioRpt.addActionListener(pCtrGUI.setRepeatAudio);
			//object type selection radio buttons group
			append(obj3DRdBt = new JRadioButton("3D Object"));
			obj3DRdBt.addActionListener(pCtrGUI.object3DSelected);
			append(videoRdBt = new JRadioButton("Video"));
			videoRdBt.addActionListener(pCtrGUI.videoSelected);
			append(textureRdBt = new JRadioButton("Texture"));
			textureRdBt.addActionListener(pCtrGUI.textureSelected);
			var btgroup:ButtonGroup = new ButtonGroup();
			btgroup.append(obj3DRdBt);
			btgroup.append(videoRdBt);
			btgroup.append(textureRdBt);
		}
		
		public function getPtList():JComboBox {
			return ptList;
		}
		
		public function getObjList():JComboBox {
			return objList;
		}
		
		public function getPtX():JTextField {
			return ptX;
		}
		
		public function getPtY():JTextField {
			return ptY;
		}
		
		public function getPtZ():JTextField {
			return ptZ;
		}
		
		public function getObjTrX():JTextField {
			return objTrX;
		}
		
		public function getObjTrY():JTextField {
			return objTrY;
		}
		
		public function getObjTrZ():JTextField {
			return objTrZ;
		}
		
		public function getObjRtX():JTextField {
			return objRtX;
		}
		
		public function getObjRtY():JTextField {
			return objRtY;
		}
		
		public function getObjRtZ():JTextField {
			return objRtZ;
		}
		
		public function getObjScX():JTextField {
			return objScX;
		}
		
		public function getObjScY():JTextField {
			return objScY;
		}
		
		public function getObjScZ():JTextField {
			return objScZ;
		}
		
		public function getRd3dObject():JRadioButton {
			return obj3DRdBt;
		}
		
		public function getRdVideoObject():JRadioButton {
			return videoRdBt;
		}
		
		public function getRdTextureObject():JRadioButton {
			return textureRdBt;
		}

		public function getAudioFilePath():JTextField {
			return objAudioFilePath;
		}
		
		public function getbtAudioLoad():JButton {
			return btnAudioLoad;
		}
		
		public function getAudioRpt():JCheckBox {
			return objAudioRpt;
		}
		
		public function getAudioCheck():JCheckBox {
			return objAudioCheck;
		}
		
		public function getbtRemovePt():JButton
		{
			return btRemovePt;
		}
		
		public function getbtRemoveObj():JButton
		{
			return btRemoveObj;
		}
		
		public function getbtSwapObj():JButton
		{
			return btSwapObj;
		}
	}
	
}