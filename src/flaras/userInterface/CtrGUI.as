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

package flaras.userInterface
{
	import flaras.constants.*;
	import flaras.controller.*;
	import flaras.entity.*;
	import flaras.entity.object3D.*;
	import flaras.io.*;
	import flaras.model.*;
	import flaras.userInterface.*;
	import flaras.userInterface.graphicUserInterfaceComponents.*;
	import flash.events.*;
	import org.aswing.*;
	import org.papervision3d.core.math.*;
	
	public class CtrGUI
	{
		private var _ctrMain:CtrMain;
		//private var aControl:CtrInteractionUI;
		private var aGUI:GraphicsUserInterface;
		private var propertiesPanel:PropertiesPanel;
		private var object3dpanel:Object3DPopupPanel;
		private var videopanel:ObjectVideoPopupPanel;
		private var texturepanel:ObjectTexturePopupPanel;
		private var _animationPanel:AnimationPanel;
		
		public function CtrGUI(ctrMain:CtrMain, pGui:GraphicsUserInterface)
		{
			_ctrMain = ctrMain;
			aGUI = pGui;
		}		
		
		public function start():void
		{
			MessageWindow.setParentComponent(propertiesPanel);
			
			propertiesPanel.getPtList().setSelectedIndex(0);
			propertiesPanel.getRd3dObject().setSelected(true);
			radioObj3DSelected(null);
		}
		
		public function finishedFileCopying(path:String, destiny:String):void
		{			
			var tempindex:int;
			if (propertiesPanel.getObjList().getSelectedItem() == "New")
			{
				tempindex = propertiesPanel.getObjList().getItemCount();
				if (destiny == "dae/")
				{
					_ctrMain.ctrPoint.getCtrListOfObjects(getCurrentSelectedPoint()).addScene(path, Number3D.ZERO, Number3D.ZERO, new Number3D(1, 1, 1), false, "", 0, 0, false, "", false, false, "", 0, 0, false, false, 0, 0, 0, 0);
				}
				if (destiny == "textures/")
				{
					_ctrMain.ctrPoint.getCtrListOfObjects(getCurrentSelectedPoint()).addScene("", Number3D.ZERO, Number3D.ZERO, new Number3D(1, 1, 1), true, path, GeneralConstants.TEXTURE_DEFAULT_WIDTH, GeneralConstants.TEXTURE_DEFAULT_HEIGHT, false, "", false, false, "", 0, 0, false, false, 0, 0, 0, 0);
				}
				if (destiny == "videos/")
				{
					_ctrMain.ctrPoint.getCtrListOfObjects(getCurrentSelectedPoint()).addScene("", Number3D.ZERO, Number3D.ZERO, new Number3D(1, 1, 1), false, "", 0, 0, false, "", false, true, path, GeneralConstants.VIDEO_DEFAULT_WIDTH, GeneralConstants.VIDEO_DEFAULT_HEIGHT, false, false, 0, 0, 0, 0);
				}
				comboBoxContentsUpdate(propertiesPanel.getObjList(), _ctrMain.ctrPoint.getListOfPoints()[getCurrentSelectedPoint()].getListOfFlarasScenes().length);
				propertiesPanel.getObjList().setSelectedIndex(tempindex);
			}
			else
			{
				if (destiny == "dae/")
				{
					_ctrMain.ctrPoint.getCtrListOfObjects(getCurrentSelectedPoint()).updateRebuildScene(getCurrentSelectedScene(), path, new Number3D(new Number(propertiesPanel.getObjTrX().getText()), new Number(propertiesPanel.getObjTrY().getText()), new Number(propertiesPanel.getObjTrZ().getText())), new Number3D(new Number(propertiesPanel.getObjRtX().getText()), new Number(propertiesPanel.getObjRtY().getText()), new Number(propertiesPanel.getObjRtZ().getText())), new Number3D(new Number(propertiesPanel.getObjScX().getText()), new Number(propertiesPanel.getObjScY().getText()), new Number(propertiesPanel.getObjScZ().getText())), false, "", 0, 0, propertiesPanel.getAudioCheck().isSelected(), propertiesPanel.getAudioFilePath().getText(), propertiesPanel.getAudioRpt().isSelected(), false, "", 0, 0, false, _animationPanel.getHasAnimation(), _animationPanel.getAnimationPeriod(), _animationPanel.getAnimationRotationAxis(), _animationPanel.getAnimationRadius(), _animationPanel.getAnimationDirection());
				}
				if (destiny == "textures/")
				{
					_ctrMain.ctrPoint.getCtrListOfObjects(getCurrentSelectedPoint()).updateRebuildScene(getCurrentSelectedScene(), "", new Number3D(new Number(propertiesPanel.getObjTrX().getText()), new Number(propertiesPanel.getObjTrY().getText()), new Number(propertiesPanel.getObjTrZ().getText())), new Number3D(new Number(propertiesPanel.getObjRtX().getText()), new Number(propertiesPanel.getObjRtY().getText()), new Number(propertiesPanel.getObjRtZ().getText())), new Number3D(new Number(propertiesPanel.getObjScX().getText()), new Number(propertiesPanel.getObjScY().getText()), new Number(propertiesPanel.getObjScZ().getText())), true, path, GeneralConstants.TEXTURE_DEFAULT_WIDTH, GeneralConstants.TEXTURE_DEFAULT_HEIGHT, propertiesPanel.getAudioCheck().isSelected(), propertiesPanel.getAudioFilePath().getText(), propertiesPanel.getAudioRpt().isSelected(), false, "", 0, 0, false, _animationPanel.getHasAnimation(), _animationPanel.getAnimationPeriod(), _animationPanel.getAnimationRotationAxis(), _animationPanel.getAnimationRadius(), _animationPanel.getAnimationDirection());
				}
				if (destiny == "videos/")
				{
					_ctrMain.ctrPoint.getCtrListOfObjects(getCurrentSelectedPoint()).updateRebuildScene(getCurrentSelectedScene(), "", new Number3D(new Number(propertiesPanel.getObjTrX().getText()), new Number(propertiesPanel.getObjTrY().getText()), new Number(propertiesPanel.getObjTrZ().getText())), new Number3D(new Number(propertiesPanel.getObjRtX().getText()), new Number(propertiesPanel.getObjRtY().getText()), new Number(propertiesPanel.getObjRtZ().getText())), new Number3D(new Number(propertiesPanel.getObjScX().getText()), new Number(propertiesPanel.getObjScY().getText()), new Number(propertiesPanel.getObjScZ().getText())), false, "", 0, 0, propertiesPanel.getAudioCheck().isSelected(), propertiesPanel.getAudioFilePath().getText(), propertiesPanel.getAudioRpt().isSelected(), true, path, GeneralConstants.VIDEO_DEFAULT_WIDTH, GeneralConstants.VIDEO_DEFAULT_HEIGHT, false, _animationPanel.getHasAnimation(), _animationPanel.getAnimationPeriod(), _animationPanel.getAnimationRotationAxis(), _animationPanel.getAnimationRadius(), _animationPanel.getAnimationDirection());
				}
				
				if (destiny == "audios/")
				{
					_ctrMain.ctrPoint.getCtrListOfObjects(getCurrentSelectedPoint()).updateAddAudio(getCurrentSelectedScene(), path, propertiesPanel.getAudioRpt().isSelected());
				}
				fillPropertiesFields();
			}
		}
		
		public function updatePointPosition(e:Event):void
		{
			_ctrMain.ctrPoint.updatePointPosition(getCurrentSelectedPoint(), new Number3D(new Number(propertiesPanel.getPtX().getText()), new Number(propertiesPanel.getPtY().getText()), new Number(propertiesPanel.getPtZ().getText())));
		}
		
		public function updateSceneTranslation(e:Event):void
		{
			_ctrMain.ctrPoint.getCtrListOfObjects(getCurrentSelectedPoint()).updateTranslation(getCurrentSelectedScene(), new Number3D(new Number(propertiesPanel.getObjTrX().getText()), new Number(propertiesPanel.getObjTrY().getText()), new Number(propertiesPanel.getObjTrZ().getText())));
		}
		
		public function updateSceneRotation(e:Event):void
		{
			_ctrMain.ctrPoint.getCtrListOfObjects(getCurrentSelectedPoint()).updateRotation(getCurrentSelectedScene(), new Number3D(new Number(propertiesPanel.getObjRtX().getText()), new Number(propertiesPanel.getObjRtY().getText()), new Number(propertiesPanel.getObjRtZ().getText())));
		}
		
		public function updateSceneScale(e:Event):void
		{
			_ctrMain.ctrPoint.getCtrListOfObjects(getCurrentSelectedPoint()).updateScale(getCurrentSelectedScene(), new Number3D(new Number(propertiesPanel.getObjScX().getText()), new Number(propertiesPanel.getObjScY().getText()), new Number(propertiesPanel.getObjScZ().getText())));
		}
		
		public function updateSceneVideoSize(e:Event):void
		{
			_ctrMain.ctrPoint.getCtrListOfObjects(getCurrentSelectedPoint()).updateVideoSize(getCurrentSelectedScene(), new Number(videopanel.getObjVideoWidth().getText()), new Number(videopanel.getObjVideoHeight().getText()));
		}
		
		public function updateSceneTextureSize(e:Event):void
		{
			_ctrMain.ctrPoint.getCtrListOfObjects(getCurrentSelectedPoint()).updateTextureSize(getCurrentSelectedScene(), new Number(texturepanel.getObjTextureWidth().getText()), new Number(texturepanel.getObjTextureHeight().getText()));
		}
		
		public function updateAnimationState(newState:Boolean):void
		{	
			if (newState)
			{
				_ctrMain.ctrPoint.getCtrListOfObjects(getCurrentSelectedPoint()).updateAddAnimation(getCurrentSelectedScene(), _animationPanel.getAnimationPeriod(), _animationPanel.getAnimationRotationAxis(), _animationPanel.getAnimationRadius(), _animationPanel.getAnimationDirection());
			}
			else
			{
				_ctrMain.ctrPoint.getCtrListOfObjects(getCurrentSelectedPoint()).updateRemoveAnimation(getCurrentSelectedScene());
			}
		}
		
		public function updateAnimationProperties(e:Event):void
		{
			_ctrMain.ctrPoint.getCtrListOfObjects(getCurrentSelectedPoint()).updateAnimationProperties(getCurrentSelectedScene(), _animationPanel.getAnimationPeriod(), _animationPanel.getAnimationRotationAxis(), _animationPanel.getAnimationRadius(), _animationPanel.getAnimationDirection());
		}
		
		public function setRepeatAudio(e:Event):void
		{
			_ctrMain.ctrPoint.getCtrListOfObjects(getCurrentSelectedPoint()).updateAudioRepeat(getCurrentSelectedScene(), propertiesPanel.getAudioRpt().isSelected());
		}
		
		public function setRepeatVideo(e:Event):void
		{
			_ctrMain.ctrPoint.getCtrListOfObjects(getCurrentSelectedPoint()).updateVideoRepeat(getCurrentSelectedScene(), videopanel.getObjVideoRpt().isSelected());
		}
		
		public function filterValidCharFromTextField(ke:KeyboardEvent):void
		{
			var text:String;
			var newCharArray:Array;
			var j:uint;
			var item:String;
			var jtf:JTextField;
			
			jtf = JTextField(ke.currentTarget);
			
			text = jtf.getText();
			
			j = 0;
			newCharArray = new Array();
			for (var i:uint = 0; i < text.length; i++)
			{
				item = text.charAt(i);
				if ((item >= '0' && item <= '9') || (item == '.') || (item == '-'))
				{
					newCharArray[j] = item;
					j++;
				}
			}
			
			jtf.setText(newCharArray.join(''));
		}
		
		public function filterValidStrictPositiveCharFromTextField(ke:KeyboardEvent):void
		{
			var text:String;
			var newCharArray:Array;
			var j:uint;
			var item:String;
			var jtf:JTextField;
			
			jtf = JTextField(ke.currentTarget);
			
			text = jtf.getText();
			
			j = 0;
			newCharArray = new Array();
			for (var i:uint = 0; i < text.length; i++)
			{
				item = text.charAt(i);
				if ((item >= '0' && item <= '9') || (item == '.'))
				{
					newCharArray[j] = item;
					j++;
				}
			}
			
			jtf.setText(newCharArray.join(''));
		}
		
		public function comboBoxReload():void
		{
			propertiesPanel.getPtList().setSelectedIndex(0);
			cleanPointFields();
			cleanSceneFields();
			comboBoxContentsUpdate(propertiesPanel.getPtList(), _ctrMain.ctrPoint.getNumberOfPoints());
			comboBoxContentsUpdate(propertiesPanel.getObjList(), new Vector.<FlarasScene>);
		}
		
		public function comboBoxContentsUpdate(comboBox:JComboBox, numberOfPoints:uint):void
		{
			var array:Array = new Array();
			array.push("New");
			for (var i:int = 1; i <= numberOfPoints; i++)
			{
				array.push(i);
			}
			comboBox.setListData(array);
		}
		
		public function audioLoad(e:Event):void
		{
			FileCopy.audioCopy(_ctrMain.ctrUserProject.getCurrentProjectTempFolder(), this);
		}
		
		public function fileLoad(e:Event):void
		{
			if (propertiesPanel.getPtList().getSelectedItem() == "New")
			{
				var tempindex:int = propertiesPanel.getPtList().getItemCount();
				_ctrMain.ctrPoint.addPoint(Number3D.ZERO);
				comboBoxContentsUpdate(propertiesPanel.getPtList(), _ctrMain.ctrPoint.getNumberOfPoints());
				propertiesPanel.getPtList().setSelectedIndex(tempindex);
			}
			FileCopy.colladaCopy(_ctrMain.ctrUserProject.getCurrentProjectTempFolder(), this);
		}
		
		public function videoLoad(e:Event):void
		{
			if (propertiesPanel.getPtList().getSelectedItem() == "New")
			{
				var tempindex:int = propertiesPanel.getPtList().getItemCount();
				_ctrMain.ctrPoint.addPoint(Number3D.ZERO);
				comboBoxContentsUpdate(propertiesPanel.getPtList(), _ctrMain.ctrPoint.getNumberOfPoints());
				propertiesPanel.getPtList().setSelectedIndex(tempindex);
			}
			FileCopy.videoCopy(_ctrMain.ctrUserProject.getCurrentProjectTempFolder(), this);
		}
		
		public function textureLoad(e:Event):void
		{
			if (propertiesPanel.getPtList().getSelectedItem() == "New")
			{
				var tempindex:int = propertiesPanel.getPtList().getItemCount();
				_ctrMain.ctrPoint.addPoint(Number3D.ZERO);
				comboBoxContentsUpdate(propertiesPanel.getPtList(), _ctrMain.ctrPoint.getNumberOfPoints());
				propertiesPanel.getPtList().setSelectedIndex(tempindex);
			}
			FileCopy.textureCopy(_ctrMain.ctrUserProject.getCurrentProjectTempFolder(), this);
		}		
		
		public function removePoint(e:Event):void
		{
			JOptionPane.showMessageDialog("Confirmation", "Are you sure about erasing this point?", null, propertiesPanel, true, null, 12).getYesButton().addActionListener(remPt);
		}
		
		private function remPt(e:Event):void
		{
			_ctrMain.ctrPoint.removePoint(getCurrentSelectedPoint());
			comboBoxContentsUpdate(propertiesPanel.getPtList(), _ctrMain.ctrPoint.getNumberOfPoints());
			propertiesPanel.getPtList().setSelectedIndex(0);
		}
		
		public function removeObject(e:Event):void
		{
			JOptionPane.showMessageDialog("Confirmation", "Are you sure about erasing this scene?", null, propertiesPanel, true, null, 12).getYesButton().addActionListener(remObj);
		}
		
		private function remObj(e:Event):void
		{
			_ctrMain.ctrPoint.getCtrListOfObjects(getCurrentSelectedPoint()).removeScene(getCurrentSelectedScene());
			
			comboBoxContentsUpdate(propertiesPanel.getObjList(), _ctrMain.ctrPoint.getListOfPoints()[getCurrentSelectedPoint()].getListOfFlarasScenes().length);
			propertiesPanel.getObjList().setSelectedIndex(0);
		}
		
		public function swapObject(e:Event):void
		{
			var numberOfScenes:uint;
			var currentScenePos:uint;
			
			//-1 for not couting the New string
			numberOfScenes = propertiesPanel.getObjList().getItemCount() - 1;
			currentScenePos = propertiesPanel.getObjList().getSelectedIndex();
			
			aGUI.getSwapWindow().openSwapWindow(numberOfScenes, currentScenePos);
		}
		
		public function swapFunction(pos2Swap:uint):void
		{
			_ctrMain.ctrPoint.getCtrListOfObjects(getCurrentSelectedPoint()).swapScenePositionTo(getCurrentSelectedScene(), pos2Swap - 1)
			
			comboBoxContentsUpdate(propertiesPanel.getObjList(), _ctrMain.ctrPoint.getListOfPoints()[getCurrentSelectedPoint()].getListOfFlarasScenes().length);
			propertiesPanel.getObjList().setSelectedIndex(0);
		}
		
		private function cleanPointFields():void
		{
			propertiesPanel.getPtX().setText("");
			propertiesPanel.getPtY().setText("");
			propertiesPanel.getPtZ().setText("");
		}
		
		private function cleanSceneFields():void
		{			
			propertiesPanel.getObjTrX().setText("");
			propertiesPanel.getObjTrY().setText("");
			propertiesPanel.getObjTrZ().setText("");
			propertiesPanel.getObjRtX().setText("");
			propertiesPanel.getObjRtY().setText("");
			propertiesPanel.getObjRtZ().setText("");
			propertiesPanel.getObjScX().setText("");
			propertiesPanel.getObjScY().setText("");
			propertiesPanel.getObjScZ().setText("");
			propertiesPanel.getAudioFilePath().setText("");
			
			propertiesPanel.getAudioRpt().setSelected(false);
			propertiesPanel.getAudioCheck().setSelected(false);
			
			//disabling audio related buttons
			propertiesPanel.getbtAudioLoad().setEnabled(false);
			propertiesPanel.getAudioFilePath().setEnabled(false);
			propertiesPanel.getAudioRpt().setEnabled(false);
			
			object3dpanel.getObjFile().setText("");
			
			videopanel.getObjVideo().setText("");
			videopanel.getObjVideoHeight().setText("");
			videopanel.getObjVideoWidth().setText("");
			videopanel.getObjVideoRpt().setSelected(false);
			
			texturepanel.getObjTexture().setText("");
			texturepanel.getObjTextureHeight().setText("");
			texturepanel.getObjTextureWidth().setText("");
			
			_animationPanel.setHasAnimation(false);
			_animationPanel.setAnimationRotationAxis(Animation.X_ROTATION_AXIS);
			_animationPanel.setAnimationPeriod(10);
			_animationPanel.setAnimationRadius(0);
			_animationPanel.setAnimationRotationDirection(1);
		}
		
		public function audioSelected(e:Event):void
		{
			//if the has audio checkbox was marked
			if (propertiesPanel.getAudioCheck().isSelected())
			{
				setEnabledAudioPropertiesFields(true);
			}
			//if the has audio checkbox was unmarked
			else
			{
				var audioData:AudioScene;
				audioData = _ctrMain.ctrPoint.getCtrListOfObjects(getCurrentSelectedPoint()).getAudioData(getCurrentSelectedScene());
				
				if (audioData)
				{
					_ctrMain.ctrPoint.getCtrListOfObjects(getCurrentSelectedPoint()).updateRemoveAudio(getCurrentSelectedScene());
				}
				propertiesPanel.getAudioFilePath().setText("");	
				setEnabledAudioPropertiesFields(false);
			}
		}
		
		public function radioObj3DSelected(e:Event):void
		{
			propertiesPanel.remove(videopanel);
			propertiesPanel.remove(texturepanel);
			
			propertiesPanel.append(object3dpanel);
			object3dpanel.show();
		}

		public function radioVideoSelected(e:Event):void
		{
			propertiesPanel.remove(object3dpanel);
			propertiesPanel.remove(texturepanel);
			
			propertiesPanel.append(videopanel);
			videopanel.show();
				
			if (videopanel.getObjVideo().getText() == "")
			{
				setEnabledVideoPropertiesFields(false);
			}
			else
			{
				setEnabledVideoPropertiesFields(true);
			}
		}
		
		public function radioTextureSelected(e:Event):void
		{
			propertiesPanel.remove(object3dpanel);
			propertiesPanel.remove(videopanel);
			
			propertiesPanel.append(texturepanel);
			texturepanel.show();
				
			if (texturepanel.getObjTexture().getText() == "")
			{
				setEnabledTexturePropertiesFields(false);
			}
			else
			{
				setEnabledTexturePropertiesFields(true);
			}
		}
	
		
		
		public function pointSelected(e:Event):void
		{
			var position:Number3D;
			
			cleanPointFields();
			if (propertiesPanel.getPtList().getSelectedItem() == "New")
			{
				setEnabledPointPropertiesFields(false);
				_ctrMain.ctrPoint.disableAllPointsUI();
				comboBoxContentsUpdate(propertiesPanel.getObjList(), new Vector.<FlarasScene>());
				propertiesPanel.getObjList().setSelectedIndex(0);
			}
			else
			{
				setEnabledPointPropertiesFields(true);
				
				_ctrMain.ctrPoint.disableAllPointsUI();
				_ctrMain.ctrPoint.enablePointUI(getCurrentSelectedPoint());
				
				position = _ctrMain.ctrPoint.getPosition(getCurrentSelectedPoint());
				propertiesPanel.getPtX().setText(position.x + "");
				propertiesPanel.getPtY().setText(position.y + "");
				propertiesPanel.getPtZ().setText(position.z + "");
				
				comboBoxContentsUpdate(propertiesPanel.getObjList(), _ctrMain.ctrPoint.getListOfPoints()[getCurrentSelectedPoint()].getListOfFlarasScenes().length);
				
				propertiesPanel.getObjList().setSelectedIndex(0);
			}
		}
		
		public function objectSelected(e:Event):void
		{
			var translation:Number3D;
			var rotation:Number3D;
			var scale:Number3D;
			var audioData:AudioScene;
			var videoData:VideoScene;
			var textureData:TextureScene;
			var virtualObjectData:VirtualObjectScene;
			var animationData:AnimationScene;
			
			cleanSceneFields();
			if (String(propertiesPanel.getObjList().getSelectedItem()) == "New")
			{
				setEnabledScenePropertiesFields(false);
				_ctrMain.ctrPoint.disableAllPoints(false);
			}
			else
			{
				setEnabledScenePropertiesFields(true);
				_ctrMain.ctrPoint.disableAllPoints(false);
				fillPropertiesFields();
				_ctrMain.ctrPoint.goToObject(getCurrentSelectedPoint(), getCurrentSelectedScene());
			}		
		}
		
		public function fillPropertiesFields():void
		{
			var translation:Number3D;
			var rotation:Number3D;
			var scale:Number3D;
			var audioData:AudioScene;
			var videoData:VideoScene;
			var textureData:TextureScene;
			var virtualObjectData:VirtualObjectScene;
			var animationData:AnimationScene;
			
			cleanSceneFields();
			
			translation = _ctrMain.ctrPoint.getCtrListOfObjects(getCurrentSelectedPoint()).getTranslation(getCurrentSelectedScene());
			rotation = _ctrMain.ctrPoint.getCtrListOfObjects(getCurrentSelectedPoint()).getRotation(getCurrentSelectedScene());
			scale = _ctrMain.ctrPoint.getCtrListOfObjects(getCurrentSelectedPoint()).getScale(getCurrentSelectedScene());
			
			virtualObjectData = _ctrMain.ctrPoint.getCtrListOfObjects(getCurrentSelectedPoint()).getVirtualObjectData(getCurrentSelectedScene());
			videoData = _ctrMain.ctrPoint.getCtrListOfObjects(getCurrentSelectedPoint()).getVideoData(getCurrentSelectedScene());
			textureData = _ctrMain.ctrPoint.getCtrListOfObjects(getCurrentSelectedPoint()).getTextureData(getCurrentSelectedScene());
			audioData = _ctrMain.ctrPoint.getCtrListOfObjects(getCurrentSelectedPoint()).getAudioData(getCurrentSelectedScene());
			animationData = _ctrMain.ctrPoint.getCtrListOfObjects(getCurrentSelectedPoint()).getAnimationData(getCurrentSelectedScene());
		
			propertiesPanel.getObjTrX().setText(translation.x + "");
			propertiesPanel.getObjTrY().setText(translation.y + "");
			propertiesPanel.getObjTrZ().setText(translation.z + "");
			propertiesPanel.getObjRtX().setText(rotation.x + "");
			propertiesPanel.getObjRtY().setText(rotation.y + "");
			propertiesPanel.getObjRtZ().setText(rotation.z + "");
			propertiesPanel.getObjScX().setText(scale.x + "");
			propertiesPanel.getObjScY().setText(scale.y + "");
			propertiesPanel.getObjScZ().setText(scale.z + "");
			
			if (animationData)
			{
				_animationPanel.setHasAnimation(true);
				_animationPanel.setAnimationPeriod(animationData.getPeriod());
				_animationPanel.setAnimationRotationAxis(animationData.getRotationAxis());
				_animationPanel.setAnimationRadius(animationData.getRadius());
				_animationPanel.setAnimationRotationDirection(animationData.getRotationDirection());
			}
			if (audioData)
			{
				propertiesPanel.getAudioCheck().setSelected(true);
				propertiesPanel.getAudioFilePath().setEnabled(true);
				propertiesPanel.getAudioFilePath().setText(audioData.getAudioFilePath());
				propertiesPanel.getAudioRpt().setEnabled(true);
				propertiesPanel.getAudioRpt().setSelected(audioData.getRepeatAudio());
				propertiesPanel.getbtAudioLoad().setEnabled(true);
			}	
			
			if (videoData)
			{
				propertiesPanel.getRdVideoObject().setSelected(true);
				radioVideoSelected(null);
				videopanel.getObjVideo().setEnabled(true);
				videopanel.getObjVideo().setText(videoData.getVideoFilePath());
				videopanel.getObjVideoHeight().setEnabled(true);
				videopanel.getObjVideoHeight().setText(videoData.getHeight().toString());
				videopanel.getObjVideoWidth().setEnabled(true);
				videopanel.getObjVideoWidth().setText(videoData.getWidth().toString());
				videopanel.getObjVideoRpt().setEnabled(true);
				videopanel.getObjVideoRpt().setSelected(videoData.getRepeatVideo());
				videopanel.getBtnVideoLoad().setEnabled(true);
			}
			else if (textureData)
			{
				propertiesPanel.getRdTextureObject().setSelected(true);
				radioTextureSelected(null);
				texturepanel.getObjTexture().setEnabled(true);
				texturepanel.getObjTexture().setText(textureData.getTextureFilePath());
				texturepanel.getObjTextureHeight().setEnabled(true);
				texturepanel.getObjTextureHeight().setText(textureData.getHeight().toString());
				texturepanel.getObjTextureWidth().setEnabled(true);
				texturepanel.getObjTextureWidth().setText(textureData.getWidth().toString());
				texturepanel.getBtnTextureLoad().setEnabled(true);
			}
			else
			{
				propertiesPanel.getRd3dObject().setSelected(true);
				radioObj3DSelected(null);
				object3dpanel.getObjFile().setEnabled(true);
				object3dpanel.getObjFile().setText(virtualObjectData.getPath3DObjectFile());
				object3dpanel.getBtnObject3dLoad().setEnabled(true);
			}			
		}
		
		
		public function getListOfPoints():Vector.<Point>
		{
			return _ctrMain.ctrPoint.getListOfPoints();
		}
		
		
		
		private function getCurrentSelectedPoint():uint
		{
			return propertiesPanel.getPtList().getSelectedIndex() - 1;
		}
		
		private function getCurrentSelectedScene():uint
		{
			return propertiesPanel.getObjList().getSelectedIndex() - 1;
		}
		
		private function setEnabledPointPropertiesFields(enabled:Boolean):void
		{
			propertiesPanel.getPtX().setEnabled(enabled);
			propertiesPanel.getPtY().setEnabled(enabled);
			propertiesPanel.getPtZ().setEnabled(enabled);
			propertiesPanel.getbtRemovePt().setEnabled(enabled);
		}
		
		private function setEnabledScenePropertiesFields(enabled:Boolean):void
		{
			propertiesPanel.getbtRemoveObj().setEnabled(enabled);
			propertiesPanel.getbtSwapObj().setEnabled(enabled);
			
			propertiesPanel.getObjTrX().setEnabled(enabled);
			propertiesPanel.getObjTrY().setEnabled(enabled);
			propertiesPanel.getObjTrZ().setEnabled(enabled);
			
			propertiesPanel.getObjRtX().setEnabled(enabled);
			propertiesPanel.getObjRtY().setEnabled(enabled);
			propertiesPanel.getObjRtZ().setEnabled(enabled);
			
			propertiesPanel.getObjScX().setEnabled(enabled);
			propertiesPanel.getObjScY().setEnabled(enabled);
			propertiesPanel.getObjScZ().setEnabled(enabled);
			
			setEnabledVideoPropertiesFields(enabled);
			setEnabledTexturePropertiesFields(enabled);
			
			propertiesPanel.getAudioCheck().setEnabled(enabled);
			
			_animationPanel.getJcbHasAnimation().setEnabled(enabled);
		}
		
		private function setEnabledVideoPropertiesFields(enabled:Boolean):void
		{
			videopanel.getObjVideoWidth().setEnabled(enabled)
			videopanel.getObjVideoHeight().setEnabled(enabled)
			videopanel.getObjVideoRpt().setEnabled(enabled);
		}
		
		private function setEnabledTexturePropertiesFields(enabled:Boolean):void
		{
			texturepanel.getObjTextureWidth().setEnabled(enabled);
			texturepanel.getObjTextureHeight().setEnabled(enabled);
		}
		
		private function setEnabledAudioPropertiesFields(enabled:Boolean):void
		{
			propertiesPanel.getbtAudioLoad().setEnabled(enabled);
			propertiesPanel.getAudioFilePath().setEnabled(enabled);
			propertiesPanel.getAudioRpt().setEnabled(enabled);
		}		
		
		public function setPropertiesPanel(propertiesPanel:PropertiesPanel):void
		{
			this.propertiesPanel = propertiesPanel;
		}
		
		public function setObject3Dpanel(p3dpanel:Object3DPopupPanel):void
		{
			this.object3dpanel = p3dpanel;
		}
		
		public function setObjectVideoPanel(pVideoPanel:ObjectVideoPopupPanel):void
		{
			this.videopanel = pVideoPanel;
		}
		
		public function setObjectTexturePanel(pTexturePanel:ObjectTexturePopupPanel):void
		{
			this.texturepanel = pTexturePanel;
		}
		
		public function setAnimationPanel(pAnimationPanel:AnimationPanel):void
		{
			this._animationPanel = pAnimationPanel;
		}
		
		public function getGUI():GraphicsUserInterface
		{
			return aGUI;
		}
	}
}