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
	import flaras.io.*;
	import flaras.model.*;
	import flaras.model.point.*;
	import flaras.userInterface.*;
	import flaras.userInterface.graphicUserInterfaceComponents.*;
	import flaras.view.scene.ViewAnimationScene;
	import flash.events.*;
	import org.aswing.*;
	import org.papervision3d.core.math.*;
	
	public class CtrGUI
	{
		private var _ctrMain:CtrMain;
		private var _gui:GraphicsUserInterface;
		
		public function CtrGUI(ctrMain:CtrMain)
		{
			_ctrMain = ctrMain;
			_gui = new GraphicsUserInterface(ctrMain, this);
			init();
		}		
		
		public function init():void
		{
			_gui.getPropertiesPanel().getPtList().setSelectedIndex(0);
			_gui.getPropertiesPanel().getRd3dObject().setSelected(true);
			radioObj3DSelected(null);
		}
		
		public function finishedFileCopying(path:String, destiny:String):void
		{			
			var tempindex:int;
			if (_gui.getPropertiesPanel().getObjList().getSelectedItem() == "New")
			{
				tempindex = _gui.getPropertiesPanel().getObjList().getItemCount();
				if (destiny == "dae/")
				{
					_ctrMain.ctrPoint.getCtrScene(getCurrentSelectedPoint()).addScene(path, Number3D.ZERO, Number3D.ZERO, new Number3D(1, 1, 1), false, "", 0, 0, false, "", false, false, "", 0, 0, false, false, 0, 0, 0, 0);
				}
				if (destiny == "textures/")
				{
					_ctrMain.ctrPoint.getCtrScene(getCurrentSelectedPoint()).addScene("", Number3D.ZERO, Number3D.ZERO, new Number3D(1, 1, 1), true, path, GeneralConstants.TEXTURE_DEFAULT_WIDTH, GeneralConstants.TEXTURE_DEFAULT_HEIGHT, false, "", false, false, "", 0, 0, false, false, 0, 0, 0, 0);
				}
				if (destiny == "videos/")
				{
					_ctrMain.ctrPoint.getCtrScene(getCurrentSelectedPoint()).addScene("", Number3D.ZERO, Number3D.ZERO, new Number3D(1, 1, 1), false, "", 0, 0, false, "", false, true, path, GeneralConstants.VIDEO_DEFAULT_WIDTH, GeneralConstants.VIDEO_DEFAULT_HEIGHT, false, false, 0, 0, 0, 0);
				}
				comboBoxContentsUpdate(_gui.getPropertiesPanel().getObjList(), _ctrMain.ctrPoint.getListOfPoints()[getCurrentSelectedPoint()].getListOfFlarasScenes().length);
				_gui.getPropertiesPanel().getObjList().setSelectedIndex(tempindex);
			}
			else
			{
				if (destiny == "dae/")
				{
					_ctrMain.ctrPoint.getCtrScene(getCurrentSelectedPoint()).updateRebuildScene(getCurrentSelectedScene(), path, new Number3D(new Number(_gui.getPropertiesPanel().getObjTrX().getText()), new Number(_gui.getPropertiesPanel().getObjTrY().getText()), new Number(_gui.getPropertiesPanel().getObjTrZ().getText())), new Number3D(new Number(_gui.getPropertiesPanel().getObjRtX().getText()), new Number(_gui.getPropertiesPanel().getObjRtY().getText()), new Number(_gui.getPropertiesPanel().getObjRtZ().getText())), new Number3D(new Number(_gui.getPropertiesPanel().getObjScX().getText()), new Number(_gui.getPropertiesPanel().getObjScY().getText()), new Number(_gui.getPropertiesPanel().getObjScZ().getText())), false, "", 0, 0, _gui.getPropertiesPanel().getAudioCheck().isSelected(), _gui.getPropertiesPanel().getAudioFilePath().getText(), _gui.getPropertiesPanel().getAudioRpt().isSelected(), false, "", 0, 0, false, _gui.getAnimationPanel().getHasAnimation(), _gui.getAnimationPanel().getAnimationPeriod(), _gui.getAnimationPanel().getAnimationRotationAxis(), _gui.getAnimationPanel().getAnimationRadius(), _gui.getAnimationPanel().getAnimationDirection());
				}
				if (destiny == "textures/")
				{
					_ctrMain.ctrPoint.getCtrScene(getCurrentSelectedPoint()).updateRebuildScene(getCurrentSelectedScene(), "", new Number3D(new Number(_gui.getPropertiesPanel().getObjTrX().getText()), new Number(_gui.getPropertiesPanel().getObjTrY().getText()), new Number(_gui.getPropertiesPanel().getObjTrZ().getText())), new Number3D(new Number(_gui.getPropertiesPanel().getObjRtX().getText()), new Number(_gui.getPropertiesPanel().getObjRtY().getText()), new Number(_gui.getPropertiesPanel().getObjRtZ().getText())), new Number3D(new Number(_gui.getPropertiesPanel().getObjScX().getText()), new Number(_gui.getPropertiesPanel().getObjScY().getText()), new Number(_gui.getPropertiesPanel().getObjScZ().getText())), true, path, GeneralConstants.TEXTURE_DEFAULT_WIDTH, GeneralConstants.TEXTURE_DEFAULT_HEIGHT, _gui.getPropertiesPanel().getAudioCheck().isSelected(), _gui.getPropertiesPanel().getAudioFilePath().getText(), _gui.getPropertiesPanel().getAudioRpt().isSelected(), false, "", 0, 0, false, _gui.getAnimationPanel().getHasAnimation(), _gui.getAnimationPanel().getAnimationPeriod(), _gui.getAnimationPanel().getAnimationRotationAxis(), _gui.getAnimationPanel().getAnimationRadius(), _gui.getAnimationPanel().getAnimationDirection());
				}
				if (destiny == "videos/")
				{
					_ctrMain.ctrPoint.getCtrScene(getCurrentSelectedPoint()).updateRebuildScene(getCurrentSelectedScene(), "", new Number3D(new Number(_gui.getPropertiesPanel().getObjTrX().getText()), new Number(_gui.getPropertiesPanel().getObjTrY().getText()), new Number(_gui.getPropertiesPanel().getObjTrZ().getText())), new Number3D(new Number(_gui.getPropertiesPanel().getObjRtX().getText()), new Number(_gui.getPropertiesPanel().getObjRtY().getText()), new Number(_gui.getPropertiesPanel().getObjRtZ().getText())), new Number3D(new Number(_gui.getPropertiesPanel().getObjScX().getText()), new Number(_gui.getPropertiesPanel().getObjScY().getText()), new Number(_gui.getPropertiesPanel().getObjScZ().getText())), false, "", 0, 0, _gui.getPropertiesPanel().getAudioCheck().isSelected(), _gui.getPropertiesPanel().getAudioFilePath().getText(), _gui.getPropertiesPanel().getAudioRpt().isSelected(), true, path, GeneralConstants.VIDEO_DEFAULT_WIDTH, GeneralConstants.VIDEO_DEFAULT_HEIGHT, false, _gui.getAnimationPanel().getHasAnimation(), _gui.getAnimationPanel().getAnimationPeriod(), _gui.getAnimationPanel().getAnimationRotationAxis(), _gui.getAnimationPanel().getAnimationRadius(), _gui.getAnimationPanel().getAnimationDirection());
				}
				
				if (destiny == "audios/")
				{
					_ctrMain.ctrPoint.getCtrScene(getCurrentSelectedPoint()).updateAddAudio(getCurrentSelectedScene(), path, _gui.getPropertiesPanel().getAudioRpt().isSelected());
				}
				fillPropertiesFields();
			}
		}
		
		public function updatePointPosition(e:Event):void
		{
			_ctrMain.ctrPoint.updatePointPosition(getCurrentSelectedPoint(), new Number3D(new Number(_gui.getPropertiesPanel().getPtX().getText()), new Number(_gui.getPropertiesPanel().getPtY().getText()), new Number(_gui.getPropertiesPanel().getPtZ().getText())));
		}
		
		public function updateSceneTranslation(e:Event):void
		{
			_ctrMain.ctrPoint.getCtrScene(getCurrentSelectedPoint()).updateTranslation(getCurrentSelectedScene(), new Number3D(new Number(_gui.getPropertiesPanel().getObjTrX().getText()), new Number(_gui.getPropertiesPanel().getObjTrY().getText()), new Number(_gui.getPropertiesPanel().getObjTrZ().getText())));
		}
		
		public function updateSceneRotation(e:Event):void
		{
			_ctrMain.ctrPoint.getCtrScene(getCurrentSelectedPoint()).updateRotation(getCurrentSelectedScene(), new Number3D(new Number(_gui.getPropertiesPanel().getObjRtX().getText()), new Number(_gui.getPropertiesPanel().getObjRtY().getText()), new Number(_gui.getPropertiesPanel().getObjRtZ().getText())));
		}
		
		public function updateSceneScale(e:Event):void
		{
			_ctrMain.ctrPoint.getCtrScene(getCurrentSelectedPoint()).updateScale(getCurrentSelectedScene(), new Number3D(new Number(_gui.getPropertiesPanel().getObjScX().getText()), new Number(_gui.getPropertiesPanel().getObjScY().getText()), new Number(_gui.getPropertiesPanel().getObjScZ().getText())));
		}
		
		public function updateSceneVideoSize(e:Event):void
		{
			_ctrMain.ctrPoint.getCtrScene(getCurrentSelectedPoint()).updateVideoSize(getCurrentSelectedScene(), new Number(_gui.getVideoPanel().getObjVideoWidth().getText()), new Number(_gui.getVideoPanel().getObjVideoHeight().getText()));
		}
		
		public function updateSceneTextureSize(e:Event):void
		{
			_ctrMain.ctrPoint.getCtrScene(getCurrentSelectedPoint()).updateTextureSize(getCurrentSelectedScene(), new Number(_gui.getTexturePanel().getObjTextureWidth().getText()), new Number(_gui.getTexturePanel().getObjTextureHeight().getText()));
		}
		
		public function updateAnimationState(newState:Boolean):void
		{	
			if (newState)
			{
				_ctrMain.ctrPoint.getCtrScene(getCurrentSelectedPoint()).updateAddAnimation(getCurrentSelectedScene(), _gui.getAnimationPanel().getAnimationPeriod(), _gui.getAnimationPanel().getAnimationRotationAxis(), _gui.getAnimationPanel().getAnimationRadius(), _gui.getAnimationPanel().getAnimationDirection());
			}
			else
			{
				_ctrMain.ctrPoint.getCtrScene(getCurrentSelectedPoint()).updateRemoveAnimation(getCurrentSelectedScene());
			}
		}
		
		public function updateAnimationProperties(e:Event):void
		{
			_ctrMain.ctrPoint.getCtrScene(getCurrentSelectedPoint()).updateAnimationProperties(getCurrentSelectedScene(), _gui.getAnimationPanel().getAnimationPeriod(), _gui.getAnimationPanel().getAnimationRotationAxis(), _gui.getAnimationPanel().getAnimationRadius(), _gui.getAnimationPanel().getAnimationDirection());
		}
		
		public function setRepeatAudio(e:Event):void
		{
			_ctrMain.ctrPoint.getCtrScene(getCurrentSelectedPoint()).updateAudioRepeat(getCurrentSelectedScene(), _gui.getPropertiesPanel().getAudioRpt().isSelected());
		}
		
		public function setRepeatVideo(e:Event):void
		{
			_ctrMain.ctrPoint.getCtrScene(getCurrentSelectedPoint()).updateVideoRepeat(getCurrentSelectedScene(), _gui.getVideoPanel().getObjVideoRpt().isSelected());
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
			_gui.getPropertiesPanel().getPtList().setSelectedIndex(0);
			cleanPointFields();
			cleanSceneFields();
			comboBoxContentsUpdate(_gui.getPropertiesPanel().getPtList(), _ctrMain.ctrPoint.getNumberOfPoints());
			comboBoxContentsUpdate(_gui.getPropertiesPanel().getObjList(), new Vector.<FlarasScene>);
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
			if (_gui.getPropertiesPanel().getPtList().getSelectedItem() == "New")
			{
				var tempindex:int = _gui.getPropertiesPanel().getPtList().getItemCount();
				_ctrMain.ctrPoint.addPoint(Number3D.ZERO);
				comboBoxContentsUpdate(_gui.getPropertiesPanel().getPtList(), _ctrMain.ctrPoint.getNumberOfPoints());
				_gui.getPropertiesPanel().getPtList().setSelectedIndex(tempindex);
			}
			FileCopy.colladaCopy(_ctrMain.ctrUserProject.getCurrentProjectTempFolder(), this);
		}
		
		public function videoLoad(e:Event):void
		{
			if (_gui.getPropertiesPanel().getPtList().getSelectedItem() == "New")
			{
				var tempindex:int = _gui.getPropertiesPanel().getPtList().getItemCount();
				_ctrMain.ctrPoint.addPoint(Number3D.ZERO);
				comboBoxContentsUpdate(_gui.getPropertiesPanel().getPtList(), _ctrMain.ctrPoint.getNumberOfPoints());
				_gui.getPropertiesPanel().getPtList().setSelectedIndex(tempindex);
			}
			FileCopy.videoCopy(_ctrMain.ctrUserProject.getCurrentProjectTempFolder(), this);
		}
		
		public function textureLoad(e:Event):void
		{
			if (_gui.getPropertiesPanel().getPtList().getSelectedItem() == "New")
			{
				var tempindex:int = _gui.getPropertiesPanel().getPtList().getItemCount();
				_ctrMain.ctrPoint.addPoint(Number3D.ZERO);
				comboBoxContentsUpdate(_gui.getPropertiesPanel().getPtList(), _ctrMain.ctrPoint.getNumberOfPoints());
				_gui.getPropertiesPanel().getPtList().setSelectedIndex(tempindex);
			}
			FileCopy.textureCopy(_ctrMain.ctrUserProject.getCurrentProjectTempFolder(), this);
		}		
		
		public function removePoint(e:Event):void
		{
			JOptionPane.showMessageDialog("Confirmation", "Are you sure about erasing this point?", null, _gui.getPropertiesPanel(), true, null, 12).getYesButton().addActionListener(remPt);
		}
		
		private function remPt(e:Event):void
		{
			_ctrMain.ctrPoint.removePoint(getCurrentSelectedPoint());
			comboBoxContentsUpdate(_gui.getPropertiesPanel().getPtList(), _ctrMain.ctrPoint.getNumberOfPoints());
			_gui.getPropertiesPanel().getPtList().setSelectedIndex(0);
		}
		
		public function removeObject(e:Event):void
		{
			JOptionPane.showMessageDialog("Confirmation", "Are you sure about erasing this scene?", null, _gui.getPropertiesPanel(), true, null, 12).getYesButton().addActionListener(remObj);
		}
		
		private function remObj(e:Event):void
		{
			_ctrMain.ctrPoint.getCtrScene(getCurrentSelectedPoint()).removeScene(getCurrentSelectedScene());
			
			comboBoxContentsUpdate(_gui.getPropertiesPanel().getObjList(), _ctrMain.ctrPoint.getListOfPoints()[getCurrentSelectedPoint()].getListOfFlarasScenes().length);
			_gui.getPropertiesPanel().getObjList().setSelectedIndex(0);
		}
		
		public function swapObject(e:Event):void
		{
			var numberOfScenes:uint;
			var currentScenePos:uint;
			
			//-1 for not couting the New string
			numberOfScenes = _gui.getPropertiesPanel().getObjList().getItemCount() - 1;
			currentScenePos = _gui.getPropertiesPanel().getObjList().getSelectedIndex();
			
			_gui.getSwapWindow().openSwapWindow(numberOfScenes, currentScenePos);
		}
		
		public function swapFunction(pos2Swap:uint):void
		{
			_ctrMain.ctrPoint.getCtrScene(getCurrentSelectedPoint()).swapScenePositionTo(getCurrentSelectedScene(), pos2Swap - 1)
			
			comboBoxContentsUpdate(_gui.getPropertiesPanel().getObjList(), _ctrMain.ctrPoint.getListOfPoints()[getCurrentSelectedPoint()].getListOfFlarasScenes().length);
			_gui.getPropertiesPanel().getObjList().setSelectedIndex(0);
		}
		
		private function cleanPointFields():void
		{
			_gui.getPropertiesPanel().getPtX().setText("");
			_gui.getPropertiesPanel().getPtY().setText("");
			_gui.getPropertiesPanel().getPtZ().setText("");
		}
		
		private function cleanSceneFields():void
		{			
			_gui.getPropertiesPanel().getObjTrX().setText("");
			_gui.getPropertiesPanel().getObjTrY().setText("");
			_gui.getPropertiesPanel().getObjTrZ().setText("");
			_gui.getPropertiesPanel().getObjRtX().setText("");
			_gui.getPropertiesPanel().getObjRtY().setText("");
			_gui.getPropertiesPanel().getObjRtZ().setText("");
			_gui.getPropertiesPanel().getObjScX().setText("");
			_gui.getPropertiesPanel().getObjScY().setText("");
			_gui.getPropertiesPanel().getObjScZ().setText("");
			_gui.getPropertiesPanel().getAudioFilePath().setText("");
			
			_gui.getPropertiesPanel().getAudioRpt().setSelected(false);
			_gui.getPropertiesPanel().getAudioCheck().setSelected(false);
			
			//disabling audio related buttons
			_gui.getPropertiesPanel().getbtAudioLoad().setEnabled(false);
			_gui.getPropertiesPanel().getAudioFilePath().setEnabled(false);
			_gui.getPropertiesPanel().getAudioRpt().setEnabled(false);
			
			_gui.getObj3DPanel().getObjFile().setText("");
			
			_gui.getVideoPanel().getObjVideo().setText("");
			_gui.getVideoPanel().getObjVideoHeight().setText("");
			_gui.getVideoPanel().getObjVideoWidth().setText("");
			_gui.getVideoPanel().getObjVideoRpt().setSelected(false);
			
			_gui.getTexturePanel().getObjTexture().setText("");
			_gui.getTexturePanel().getObjTextureHeight().setText("");
			_gui.getTexturePanel().getObjTextureWidth().setText("");
			
			_gui.getAnimationPanel().setHasAnimation(false);
			_gui.getAnimationPanel().setAnimationRotationAxis(ViewAnimationScene.X_ROTATION_AXIS);
			_gui.getAnimationPanel().setAnimationPeriod(10);
			_gui.getAnimationPanel().setAnimationRadius(0);
			_gui.getAnimationPanel().setAnimationRotationDirection(1);
		}
		
		public function audioSelected(e:Event):void
		{
			//if the has audio checkbox was marked
			if (_gui.getPropertiesPanel().getAudioCheck().isSelected())
			{
				setEnabledAudioPropertiesFields(true);
			}
			//if the has audio checkbox was unmarked
			else
			{
				var audioData:AudioScene;
				audioData = _ctrMain.ctrPoint.getCtrScene(getCurrentSelectedPoint()).getAudioData(getCurrentSelectedScene());
				
				if (audioData)
				{
					_ctrMain.ctrPoint.getCtrScene(getCurrentSelectedPoint()).updateRemoveAudio(getCurrentSelectedScene());
				}
				_gui.getPropertiesPanel().getAudioFilePath().setText("");	
				setEnabledAudioPropertiesFields(false);
			}
		}
		
		public function radioObj3DSelected(e:Event):void
		{
			_gui.getPropertiesPanel().remove(_gui.getVideoPanel());
			_gui.getPropertiesPanel().remove(_gui.getTexturePanel());
			
			_gui.getPropertiesPanel().append(_gui.getObj3DPanel());
			_gui.getObj3DPanel().show();
		}

		public function radioVideoSelected(e:Event):void
		{
			_gui.getPropertiesPanel().remove(_gui.getObj3DPanel());
			_gui.getPropertiesPanel().remove(_gui.getTexturePanel());
			
			_gui.getPropertiesPanel().append(_gui.getVideoPanel());
			_gui.getVideoPanel().show();
				
			if (_gui.getVideoPanel().getObjVideo().getText() == "")
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
			_gui.getPropertiesPanel().remove(_gui.getObj3DPanel());
			_gui.getPropertiesPanel().remove(_gui.getVideoPanel());
			
			_gui.getPropertiesPanel().append(_gui.getTexturePanel());
			_gui.getTexturePanel().show();
				
			if (_gui.getTexturePanel().getObjTexture().getText() == "")
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
			if (_gui.getPropertiesPanel().getPtList().getSelectedItem() == "New")
			{
				setEnabledPointPropertiesFields(false);
				_ctrMain.ctrPoint.disableAllPointsUI();
				comboBoxContentsUpdate(_gui.getPropertiesPanel().getObjList(), new Vector.<FlarasScene>());
				_gui.getPropertiesPanel().getObjList().setSelectedIndex(0);
			}
			else
			{
				setEnabledPointPropertiesFields(true);
				
				_ctrMain.ctrPoint.disableAllPointsUI();
				_ctrMain.ctrPoint.enablePointUI(getCurrentSelectedPoint());
				
				position = _ctrMain.ctrPoint.getPosition(getCurrentSelectedPoint());
				_gui.getPropertiesPanel().getPtX().setText(position.x + "");
				_gui.getPropertiesPanel().getPtY().setText(position.y + "");
				_gui.getPropertiesPanel().getPtZ().setText(position.z + "");
				
				comboBoxContentsUpdate(_gui.getPropertiesPanel().getObjList(), _ctrMain.ctrPoint.getListOfPoints()[getCurrentSelectedPoint()].getListOfFlarasScenes().length);
				
				_gui.getPropertiesPanel().getObjList().setSelectedIndex(0);
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
			if (String(_gui.getPropertiesPanel().getObjList().getSelectedItem()) == "New")
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
			
			translation = _ctrMain.ctrPoint.getCtrScene(getCurrentSelectedPoint()).getTranslation(getCurrentSelectedScene());
			rotation = _ctrMain.ctrPoint.getCtrScene(getCurrentSelectedPoint()).getRotation(getCurrentSelectedScene());
			scale = _ctrMain.ctrPoint.getCtrScene(getCurrentSelectedPoint()).getScale(getCurrentSelectedScene());
			
			virtualObjectData = _ctrMain.ctrPoint.getCtrScene(getCurrentSelectedPoint()).getVirtualObjectData(getCurrentSelectedScene());
			videoData = _ctrMain.ctrPoint.getCtrScene(getCurrentSelectedPoint()).getVideoData(getCurrentSelectedScene());
			textureData = _ctrMain.ctrPoint.getCtrScene(getCurrentSelectedPoint()).getTextureData(getCurrentSelectedScene());
			audioData = _ctrMain.ctrPoint.getCtrScene(getCurrentSelectedPoint()).getAudioData(getCurrentSelectedScene());
			animationData = _ctrMain.ctrPoint.getCtrScene(getCurrentSelectedPoint()).getAnimationData(getCurrentSelectedScene());
		
			_gui.getPropertiesPanel().getObjTrX().setText(translation.x + "");
			_gui.getPropertiesPanel().getObjTrY().setText(translation.y + "");
			_gui.getPropertiesPanel().getObjTrZ().setText(translation.z + "");
			_gui.getPropertiesPanel().getObjRtX().setText(rotation.x + "");
			_gui.getPropertiesPanel().getObjRtY().setText(rotation.y + "");
			_gui.getPropertiesPanel().getObjRtZ().setText(rotation.z + "");
			_gui.getPropertiesPanel().getObjScX().setText(scale.x + "");
			_gui.getPropertiesPanel().getObjScY().setText(scale.y + "");
			_gui.getPropertiesPanel().getObjScZ().setText(scale.z + "");
			
			if (animationData)
			{
				_gui.getAnimationPanel().setHasAnimation(true);
				_gui.getAnimationPanel().setAnimationPeriod(animationData.getPeriod());
				_gui.getAnimationPanel().setAnimationRotationAxis(animationData.getRotationAxis());
				_gui.getAnimationPanel().setAnimationRadius(animationData.getRadius());
				_gui.getAnimationPanel().setAnimationRotationDirection(animationData.getRotationDirection());
			}
			if (audioData)
			{
				_gui.getPropertiesPanel().getAudioCheck().setSelected(true);
				_gui.getPropertiesPanel().getAudioFilePath().setEnabled(true);
				_gui.getPropertiesPanel().getAudioFilePath().setText(audioData.getAudioFilePath());
				_gui.getPropertiesPanel().getAudioRpt().setEnabled(true);
				_gui.getPropertiesPanel().getAudioRpt().setSelected(audioData.getRepeatAudio());
				_gui.getPropertiesPanel().getbtAudioLoad().setEnabled(true);
			}	
			
			if (videoData)
			{
				_gui.getPropertiesPanel().getRdVideoObject().setSelected(true);
				radioVideoSelected(null);
				_gui.getVideoPanel().getObjVideo().setEnabled(true);
				_gui.getVideoPanel().getObjVideo().setText(videoData.getVideoFilePath());
				_gui.getVideoPanel().getObjVideoHeight().setEnabled(true);
				_gui.getVideoPanel().getObjVideoHeight().setText(videoData.getHeight().toString());
				_gui.getVideoPanel().getObjVideoWidth().setEnabled(true);
				_gui.getVideoPanel().getObjVideoWidth().setText(videoData.getWidth().toString());
				_gui.getVideoPanel().getObjVideoRpt().setEnabled(true);
				_gui.getVideoPanel().getObjVideoRpt().setSelected(videoData.getRepeatVideo());
				_gui.getVideoPanel().getBtnVideoLoad().setEnabled(true);
			}
			else if (textureData)
			{
				_gui.getPropertiesPanel().getRdTextureObject().setSelected(true);
				radioTextureSelected(null);
				_gui.getTexturePanel().getObjTexture().setEnabled(true);
				_gui.getTexturePanel().getObjTexture().setText(textureData.getTextureFilePath());
				_gui.getTexturePanel().getObjTextureHeight().setEnabled(true);
				_gui.getTexturePanel().getObjTextureHeight().setText(textureData.getHeight().toString());
				_gui.getTexturePanel().getObjTextureWidth().setEnabled(true);
				_gui.getTexturePanel().getObjTextureWidth().setText(textureData.getWidth().toString());
				_gui.getTexturePanel().getBtnTextureLoad().setEnabled(true);
			}
			else
			{
				_gui.getPropertiesPanel().getRd3dObject().setSelected(true);
				radioObj3DSelected(null);
				_gui.getObj3DPanel().getObjFile().setEnabled(true);
				_gui.getObj3DPanel().getObjFile().setText(virtualObjectData.getPath3DObjectFile());
				_gui.getObj3DPanel().getBtnObject3dLoad().setEnabled(true);
			}			
		}
		
		
		public function getListOfPoints():Vector.<Point>
		{
			return _ctrMain.ctrPoint.getListOfPoints();
		}
		
		
		
		private function getCurrentSelectedPoint():uint
		{
			return _gui.getPropertiesPanel().getPtList().getSelectedIndex() - 1;
		}
		
		private function getCurrentSelectedScene():uint
		{
			return _gui.getPropertiesPanel().getObjList().getSelectedIndex() - 1;
		}
		
		private function setEnabledPointPropertiesFields(enabled:Boolean):void
		{
			_gui.getPropertiesPanel().getPtX().setEnabled(enabled);
			_gui.getPropertiesPanel().getPtY().setEnabled(enabled);
			_gui.getPropertiesPanel().getPtZ().setEnabled(enabled);
			_gui.getPropertiesPanel().getbtRemovePt().setEnabled(enabled);
		}
		
		private function setEnabledScenePropertiesFields(enabled:Boolean):void
		{
			_gui.getPropertiesPanel().getbtRemoveObj().setEnabled(enabled);
			_gui.getPropertiesPanel().getbtSwapObj().setEnabled(enabled);
			
			_gui.getPropertiesPanel().getObjTrX().setEnabled(enabled);
			_gui.getPropertiesPanel().getObjTrY().setEnabled(enabled);
			_gui.getPropertiesPanel().getObjTrZ().setEnabled(enabled);
			
			_gui.getPropertiesPanel().getObjRtX().setEnabled(enabled);
			_gui.getPropertiesPanel().getObjRtY().setEnabled(enabled);
			_gui.getPropertiesPanel().getObjRtZ().setEnabled(enabled);
			
			_gui.getPropertiesPanel().getObjScX().setEnabled(enabled);
			_gui.getPropertiesPanel().getObjScY().setEnabled(enabled);
			_gui.getPropertiesPanel().getObjScZ().setEnabled(enabled);
			
			setEnabledVideoPropertiesFields(enabled);
			setEnabledTexturePropertiesFields(enabled);
			
			_gui.getPropertiesPanel().getAudioCheck().setEnabled(enabled);
			
			_gui.getAnimationPanel().getJcbHasAnimation().setEnabled(enabled);
		}
		
		private function setEnabledVideoPropertiesFields(enabled:Boolean):void
		{
			_gui.getVideoPanel().getObjVideoWidth().setEnabled(enabled)
			_gui.getVideoPanel().getObjVideoHeight().setEnabled(enabled)
			_gui.getVideoPanel().getObjVideoRpt().setEnabled(enabled);
		}
		
		private function setEnabledTexturePropertiesFields(enabled:Boolean):void
		{
			_gui.getTexturePanel().getObjTextureWidth().setEnabled(enabled);
			_gui.getTexturePanel().getObjTextureHeight().setEnabled(enabled);
		}
		
		private function setEnabledAudioPropertiesFields(enabled:Boolean):void
		{
			_gui.getPropertiesPanel().getbtAudioLoad().setEnabled(enabled);
			_gui.getPropertiesPanel().getAudioFilePath().setEnabled(enabled);
			_gui.getPropertiesPanel().getAudioRpt().setEnabled(enabled);
		}
		
		public function getGUI():GraphicsUserInterface
		{
			return _gui;
		}
	}
}