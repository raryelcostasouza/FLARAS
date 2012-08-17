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

package flaras.controller
{
	import flaras.controller.*;
	import flaras.controller.constants.*;
	import flaras.controller.io.*;
	import flaras.model.*;
	import flaras.model.point.*;
	import flaras.model.scene.*;
	import flaras.view.gui.*;
	import flaras.view.scene.*;
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
			/*_gui.getPropertiesPanel().getPtList().setSelectedIndex(0);
			_gui.getPropertiesPanel().getRd3dObject().setSelected(true);
			radioObj3DSelected(null);*/
			//_gui.getTreePanel().resetTree();
		}
		
		/*public function finishedFileCopying(path:String, destiny:String):void
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
		   _gui.getTreePanel().addScene(getCurrentSelectedPoint());
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
		 }*/
		
		public function finishedFileCopying(pFilePath:String, pCopyDestination:String):void
		{
			var indexNewScene:uint;
			var translation:Number3D;
			var rotation:Number3D;
			var scale:Number3D;
			
			indexNewScene = _ctrMain.ctrPoint.getCtrScene(getCurrentSelectedPoint2()).getNumberOfScenes();
			
			//new scene
			if (_gui.getTreePanel().isPointSelected())
			{
				if (pCopyDestination == FolderConstants.COLLADA_FOLDER)
				{
					_ctrMain.ctrPoint.getCtrScene(getCurrentSelectedPoint2()).addScene(pFilePath, Number3D.ZERO, Number3D.ZERO, new Number3D(1, 1, 1), false, "", 0, 0, false, "", false, false, "", 0, 0, false, false, 0, 0, 0, 0, "");
				}
				if (pCopyDestination == FolderConstants.TEXTURE_FOLDER)
				{
					_ctrMain.ctrPoint.getCtrScene(getCurrentSelectedPoint2()).addScene("", Number3D.ZERO, Number3D.ZERO, new Number3D(1, 1, 1), true, pFilePath, GeneralConstants.TEXTURE_DEFAULT_WIDTH, GeneralConstants.TEXTURE_DEFAULT_HEIGHT, false, "", false, false, "", 0, 0, false, false, 0, 0, 0, 0, "");
				}
				if (pCopyDestination == FolderConstants.VIDEO_FOLDER)
				{
					_ctrMain.ctrPoint.getCtrScene(getCurrentSelectedPoint2()).addScene("", Number3D.ZERO, Number3D.ZERO, new Number3D(1, 1, 1), false, "", 0, 0, false, "", false, true, pFilePath, GeneralConstants.VIDEO_DEFAULT_WIDTH, GeneralConstants.VIDEO_DEFAULT_HEIGHT, false, false, 0, 0, 0, 0, "");
				}
				
				_gui.getTreePanel().addScene(getCurrentSelectedPoint2());
				_gui.getTreePanel().selectScene(getCurrentSelectedPoint2(), indexNewScene);
			}
			//update on scene
			else
			{
				if (pCopyDestination == FolderConstants.AUDIO_FOLDER)
				{
					_ctrMain.ctrPoint.getCtrScene(getCurrentSelectedPoint2()).updateAddAudio(getCurrentSelectedScene2(), pFilePath, _gui.getScenePanel().getJCBAudioRepeat().isSelected());
					_gui.getScenePanel().getJTFAudioPath().setText(pFilePath);
					_gui.getScenePanel().getJCBAudioRepeat().setEnabled(true);
				}
				else
				{
					if (pCopyDestination == FolderConstants.COLLADA_FOLDER)
					{
						_ctrMain.ctrPoint.getCtrScene(getCurrentSelectedPoint2()).updateRebuildScene(getCurrentSelectedScene2(), pFilePath, new Number3D(new Number(_gui.getScenePanel().getJTFSceneTrX().getText()), new Number(_gui.getScenePanel().getJTFSceneTrY().getText()), new Number(_gui.getScenePanel().getJTFSceneTrZ().getText())), new Number3D(new Number(_gui.getScenePanel().getJTFSceneRotX().getText()), new Number(_gui.getScenePanel().getJTFSceneRotY().getText()), new Number(_gui.getScenePanel().getJTFSceneRotZ().getText())), new Number3D(new Number(_gui.getScenePanel().getJTFSceneScX().getText()), new Number(_gui.getScenePanel().getJTFSceneScY().getText()), new Number(_gui.getScenePanel().getJTFSceneScZ().getText())), false, "", 0, 0, _gui.getScenePanel().getJCBAudio().isSelected(), _gui.getScenePanel().getJTFAudioPath().getText(), _gui.getScenePanel().getJCBAudioRepeat().isSelected(), false, "", 0, 0, false, _gui.getScenePanel().getAnimationPanel().getHasAnimation(), _gui.getScenePanel().getAnimationPanel().getAnimationPeriod(), _gui.getScenePanel().getAnimationPanel().getAnimationRotationAxis(), _gui.getScenePanel().getAnimationPanel().getAnimationRadius(), _gui.getScenePanel().getAnimationPanel().getAnimationDirection(), _gui.getScenePanel().getJTFSceneLabel().getText());
					}
					else if (pCopyDestination == FolderConstants.TEXTURE_FOLDER)
					{
						_ctrMain.ctrPoint.getCtrScene(getCurrentSelectedPoint2()).updateRebuildScene(getCurrentSelectedScene2(), "", new Number3D(new Number(_gui.getScenePanel().getJTFSceneTrX().getText()), new Number(_gui.getScenePanel().getJTFSceneTrY().getText()), new Number(_gui.getScenePanel().getJTFSceneTrZ().getText())), new Number3D(new Number(_gui.getScenePanel().getJTFSceneRotX().getText()), new Number(_gui.getScenePanel().getJTFSceneRotY().getText()), new Number(_gui.getScenePanel().getJTFSceneRotZ().getText())), new Number3D(new Number(_gui.getScenePanel().getJTFSceneScX().getText()), new Number(_gui.getScenePanel().getJTFSceneScY().getText()), new Number(_gui.getScenePanel().getJTFSceneScZ().getText())), true, pFilePath, GeneralConstants.TEXTURE_DEFAULT_WIDTH, GeneralConstants.TEXTURE_DEFAULT_HEIGHT, _gui.getScenePanel().getJCBAudio().isSelected(), _gui.getScenePanel().getJTFAudioPath().getText(), _gui.getScenePanel().getJCBAudioRepeat().isSelected(), false, "", 0, 0, false, _gui.getScenePanel().getAnimationPanel().getHasAnimation(), _gui.getScenePanel().getAnimationPanel().getAnimationPeriod(), _gui.getScenePanel().getAnimationPanel().getAnimationRotationAxis(), _gui.getScenePanel().getAnimationPanel().getAnimationRadius(), _gui.getScenePanel().getAnimationPanel().getAnimationDirection(), _gui.getScenePanel().getJTFSceneLabel().getText());
					}
					else
					{
						_ctrMain.ctrPoint.getCtrScene(getCurrentSelectedPoint2()).updateRebuildScene(getCurrentSelectedScene2(), "", new Number3D(new Number(_gui.getScenePanel().getJTFSceneTrX().getText()), new Number(_gui.getScenePanel().getJTFSceneTrZ().getText()), new Number(_gui.getScenePanel().getJTFSceneTrZ().getText())), new Number3D(new Number(_gui.getScenePanel().getJTFSceneRotX().getText()), new Number(_gui.getScenePanel().getJTFSceneRotY().getText()), new Number(_gui.getScenePanel().getJTFSceneRotZ().getText())), new Number3D(new Number(_gui.getScenePanel().getJTFSceneScX().getText()), new Number(_gui.getScenePanel().getJTFSceneScY().getText()), new Number(_gui.getScenePanel().getJTFSceneScZ().getText())), false, "", 0, 0, _gui.getScenePanel().getJCBAudio().isSelected(), _gui.getScenePanel().getJTFAudioPath().getText(), _gui.getScenePanel().getJCBAudioRepeat().isSelected(), true, pFilePath, GeneralConstants.VIDEO_DEFAULT_WIDTH, GeneralConstants.VIDEO_DEFAULT_HEIGHT, false, _gui.getScenePanel().getAnimationPanel().getHasAnimation(), _gui.getScenePanel().getAnimationPanel().getAnimationPeriod(), _gui.getScenePanel().getAnimationPanel().getAnimationRotationAxis(), _gui.getScenePanel().getAnimationPanel().getAnimationRadius(), _gui.getScenePanel().getAnimationPanel().getAnimationDirection(), _gui.getScenePanel().getJTFSceneLabel().getText());
					}
					fillSceneGUI(getCurrentSelectedPoint2(), getCurrentSelectedScene2());
				}
			}
		}
		
		/*public function updatePointPosition(e:Event):void
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
		}*/
		
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
		
		public function resetInterface():void
		{
			/*_gui.getPropertiesPanel().getPtList().setSelectedIndex(0);
			cleanPointFields();
			cleanSceneFields();
			comboBoxContentsUpdate(_gui.getPropertiesPanel().getPtList(), _ctrMain.ctrPoint.getNumberOfPoints());
			comboBoxContentsUpdate(_gui.getPropertiesPanel().getObjList(), new Vector.<FlarasScene>);*/
			
			_gui.getTreePanel().resetTree();
		}
		
		public function initProjectTree():void
		{
			_gui.getTreePanel().initTree(_ctrMain.ctrPoint.getListOfPoints());	
		}
		
		/*public function comboBoxContentsUpdate(comboBox:JComboBox, numberOfPoints:uint):void
		{
			var array:Array = new Array();
			array.push("New");
			for (var i:int = 1; i <= numberOfPoints; i++)
			{
				array.push(i);
			}
			comboBox.setListData(array);
		}*/
		
		public function audioLoad(e:Event):void
		{
			FileCopy.audioCopy(_ctrMain.ctrUserProject.getCurrentProjectTempFolder(), this);
		}
		
		/*public function fileLoad(e:Event):void
		{
			if (_gui.getPropertiesPanel().getPtList().getSelectedItem() == "New")
			{
				var tempindex:int = _gui.getPropertiesPanel().getPtList().getItemCount();
				_ctrMain.ctrPoint.addPoint(Number3D.ZERO, "");
				_gui.getTreePanel().addPoint();
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
				_ctrMain.ctrPoint.addPoint(Number3D.ZERO, "");
				_gui.getTreePanel().addPoint();
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
				_ctrMain.ctrPoint.addPoint(Number3D.ZERO, "");
				_gui.getTreePanel().addPoint();
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
			_gui.getTreePanel().removePoint(getCurrentSelectedPoint());
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
			_gui.getTreePanel().removeScene(getCurrentSelectedPoint(), getCurrentSelectedScene());
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
				_ctrMain.ctrPoint.goToScene(getCurrentSelectedPoint(), getCurrentSelectedScene());
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
		}*/
		
		public function getGUI():GraphicsUserInterface
		{
			return _gui;
		}
		
		public function getCtrMain():CtrMain
		{
			return _ctrMain;
		}
		
		public function actionRefMarkerSelected():void 
		{
			_ctrMain.ctrPoint.disableAllPointsUI();
		}
		
		public function actionPointSelected():void
		{
			var indexPoint:uint;
			
			indexPoint = getCurrentSelectedPoint2();
			_ctrMain.ctrPoint.disableAllPointsUI();
			_ctrMain.ctrPoint.enablePointUI(indexPoint);
			fillPointGUI(indexPoint);
		}
		
		public function actionSceneSelected():void
		{
			_ctrMain.ctrPoint.disableAllPointsUI();
			_ctrMain.ctrPoint.enablePointUI(getCurrentSelectedPoint2());
			_ctrMain.ctrPoint.goToScene(getCurrentSelectedPoint2(), getCurrentSelectedScene2());
			fillSceneGUI(getCurrentSelectedPoint2(), getCurrentSelectedScene2());
		}
		
		public function listenerAddPoint(e:Event):void
		{
			_ctrMain.ctrPoint.addPoint(Number3D.ZERO, "");
			_gui.getTreePanel().addPoint();
			_gui.getTreePanel().selectPoint(_ctrMain.ctrPoint.getNumberOfPoints() - 1);
		}
		
		public function listenerToggleRefMarkerPersistence(e:Event):void
		{
			_ctrMain.ctrMarker.toggleRefMarkerPersistence();
		}
		
		public function listenerSetMarkerBaseTypePlane(e:Event):void
		{
			_ctrMain.ctrMarker.changeRefMarkerBaseType(CtrMarker.REF_BASE_RECTANGLE_PLANE);
		}
		
		public function listenerSetMarkerBaseTypeSphere(e:Event):void
		{
			_ctrMain.ctrMarker.changeRefMarkerBaseType(CtrMarker.REF_BASE_POINT);
		}
		
		public function listenerUpdatePointLabel(e:Event):void
		{
			var label:String;
			
			label = _gui.getPointPanel().getJTFPointLabel().getText();
			
			_ctrMain.ctrPoint.updatePointLabel(getCurrentSelectedPoint2(), label);
			_gui.getTreePanel().updatePointLabel(label);
		}
		
		public function listenerUpdatePointPosition(e:Event):void
		{
			var indexPoint:uint;
			var x:Number;
			var y:Number;
			var z:Number;
			
			indexPoint = getCurrentSelectedPoint2();
			x = Number(_gui.getPointPanel().getJTFPointTrX().getText());
			y = Number(_gui.getPointPanel().getJTFPointTrY().getText());
			z = Number(_gui.getPointPanel().getJTFPointTrZ().getText());
			
			_ctrMain.ctrPoint.updatePointPosition(indexPoint, new Number3D(x, y, z));
		}
		
		public function listenerRemovePoint(e:Event):void
		{
			JOptionPane.showMessageDialog("Confirmation", "Are you sure about deleting this point?\nAll child scenes will also be deleted.", null, null, true, new LoadIcon("icons/external/warning.png", 48, 48), JOptionPane.YES + JOptionPane.NO).getYesButton().addActionListener(listenerConfirmedRemovePoint);
		}
		
		public function listenerConfirmedRemovePoint(e:Event):void
		{
			_ctrMain.ctrPoint.removePoint(getCurrentSelectedPoint2());
			_gui.getTreePanel().removePoint(getCurrentSelectedPoint2());
		}
		
		public function listenerAddObj3DScene(e:Event):void
		{
			FileCopy.colladaCopy(_ctrMain.ctrUserProject.getCurrentProjectTempFolder(), this);
		}
		
		public function listenerAddVideoScene(e:Event):void
		{
			FileCopy.videoCopy(_ctrMain.ctrUserProject.getCurrentProjectTempFolder(), this);
		}
		
		public function listenerAddTextureScene(e:Event):void
		{
			FileCopy.textureCopy(_ctrMain.ctrUserProject.getCurrentProjectTempFolder(), this);
		}
		
		public function listenerUpdateSceneTranslation(e:Event):void
		{
			var x:Number;
			var y:Number;
			var z:Number;
			
			x = Number(_gui.getScenePanel().getJTFSceneTrX().getText());
			y = Number(_gui.getScenePanel().getJTFSceneTrY().getText());
			z = Number(_gui.getScenePanel().getJTFSceneTrZ().getText());
			
			_ctrMain.ctrPoint.getCtrScene(getCurrentSelectedPoint2()).updateTranslation(getCurrentSelectedScene2(), new Number3D(x, y, z));
		}
		
		public function listenerUpdateSceneRotation(e:Event):void
		{
			var rotX:Number;
			var rotY:Number;
			var rotZ:Number;
			
			rotX = Number(_gui.getScenePanel().getJTFSceneRotX().getText());
			rotY = Number(_gui.getScenePanel().getJTFSceneRotY().getText());
			rotZ = Number(_gui.getScenePanel().getJTFSceneRotZ().getText());
			
			_ctrMain.ctrPoint.getCtrScene(getCurrentSelectedPoint2()).updateRotation(getCurrentSelectedScene2(), new Number3D(rotX, rotY, rotZ));
		}
		
		public function listenerUpdateSceneScale(e:Event):void
		{
			var scX:Number;
			var scY:Number;
			var scZ:Number;
			
			scX = Number(_gui.getScenePanel().getJTFSceneScX().getText());
			scY = Number(_gui.getScenePanel().getJTFSceneScY().getText());
			scZ = Number(_gui.getScenePanel().getJTFSceneScZ().getText());
			
			_ctrMain.ctrPoint.getCtrScene(getCurrentSelectedPoint2()).updateScale(getCurrentSelectedScene2(), new Number3D(scX, scY, scZ));
		}
		
		public function listenerUpdateSceneLabel(e:Event):void
		{
			var label:String;
			
			label = _gui.getScenePanel().getJTFSceneLabel().getText();
			_ctrMain.ctrPoint.getCtrScene(getCurrentSelectedPoint2()).updateLabel(getCurrentSelectedScene2(), label);			
			_gui.getTreePanel().updateSceneLabel(label);
		}
		
		public function listenerUpdateSceneTextureSize(e:Event):void
		{
			var width:Number;
			var height:Number;
			
			width = Number(_gui.getScenePanel().getJTFTextureWidth().getText());
			height = Number(_gui.getScenePanel().getJTFTextureHeight().getText());
			
			_ctrMain.ctrPoint.getCtrScene(getCurrentSelectedPoint2()).updateTextureSize(getCurrentSelectedScene2(), width, height);
		}
		
		public function listenerUpdateSceneVideoSize(e:Event):void
		{
			var width:Number;
			var height:Number;
			
			width = Number(_gui.getScenePanel().getJTFVideoWidth().getText());
			height = Number(_gui.getScenePanel().getJTFVideoHeight().getText());
			
			_ctrMain.ctrPoint.getCtrScene(getCurrentSelectedPoint2()).updateVideoSize(getCurrentSelectedScene2(), width, height);
		}
		
		public function listenerUpdateVideoRepeat(e:Event):void
		{
			_ctrMain.ctrPoint.getCtrScene(getCurrentSelectedPoint2()).updateVideoRepeat(getCurrentSelectedScene2(), _gui.getScenePanel().getJCBVideoRepeat().isSelected());
		}
		
		public function listenerAddAudio(e:Event):void
		{
			FileCopy.audioCopy(_ctrMain.ctrUserProject.getCurrentProjectTempFolder(), this);
		}
		
		public function listenerUpdateAudioRepeat(e:Event):void
		{
			_ctrMain.ctrPoint.getCtrScene(getCurrentSelectedPoint2()).updateAudioRepeat(getCurrentSelectedScene2(), _gui.getScenePanel().getJCBAudioRepeat().isSelected());
		}
		
		public function listenerUpdateAnimationState(newState:Boolean):void
		{
			if (newState)
			{
				_ctrMain.ctrPoint.getCtrScene(getCurrentSelectedPoint2()).updateAddAnimation(getCurrentSelectedScene2(), _gui.getScenePanel().getAnimationPanel().getAnimationPeriod(), _gui.getScenePanel().getAnimationPanel().getAnimationRotationAxis(), _gui.getScenePanel().getAnimationPanel().getAnimationRadius(), _gui.getScenePanel().getAnimationPanel().getAnimationDirection());
			}
			else
			{
				_ctrMain.ctrPoint.getCtrScene(getCurrentSelectedPoint2()).updateRemoveAnimation(getCurrentSelectedScene2());
			}
		}
		
		public function listenerUpdateAnimationProperties(e:Event):void
		{
			_ctrMain.ctrPoint.getCtrScene(getCurrentSelectedPoint2()).updateAnimationProperties(getCurrentSelectedScene2(), _gui.getScenePanel().getAnimationPanel().getAnimationPeriod(), _gui.getScenePanel().getAnimationPanel().getAnimationRotationAxis(), _gui.getScenePanel().getAnimationPanel().getAnimationRadius(), _gui.getScenePanel().getAnimationPanel().getAnimationDirection());
		}
		
		public function listenerRemoveScene(e:Event):void
		{
			JOptionPane.showMessageDialog("Confirmation", "Are you sure about deleting this scene?", null, null, true, new LoadIcon("icons/external/warning.png", 48, 48), JOptionPane.YES + JOptionPane.NO).getYesButton().addActionListener(listenerConfirmedRemoveScene);
		}
		
		private function listenerConfirmedRemoveScene(e:Event):void
		{
			_ctrMain.ctrPoint.getCtrScene(getCurrentSelectedPoint2()).removeScene(getCurrentSelectedScene2());
			_gui.getTreePanel().removeScene(getCurrentSelectedPoint2(), getCurrentSelectedScene2());
		}
		
		public function listenerSwapScene(e:Event):void
		{
			var numberOfScenes:uint;
			var currentScenePos:uint;
			
			//-1 for not couting the New string
			numberOfScenes = _ctrMain.ctrPoint.getCtrScene(getCurrentSelectedPoint2()).getNumberOfScenes();
			currentScenePos = getCurrentSelectedScene2() + 1;
			
			_gui.getSwapWindow().openSwapWindow(numberOfScenes, currentScenePos);
		}
		
		public function listenerConfirmedSwapScene(pos2Swap:uint):void
		{
			var listOfSceneLabels:Vector.<String>;
			var point2Swap:uint;
			
			point2Swap = getCurrentSelectedPoint2();
			_ctrMain.ctrPoint.getCtrScene(getCurrentSelectedPoint2()).swapScenePositionTo(getCurrentSelectedScene2(), pos2Swap - 1);
			listOfSceneLabels = new Vector.<String>();
			for (var i:uint = 0; i < _ctrMain.ctrPoint.getCtrScene(getCurrentSelectedPoint2()).getNumberOfScenes(); i++)
			{
				listOfSceneLabels.push(_ctrMain.ctrPoint.getCtrScene(getCurrentSelectedPoint2()).getLabel(i));
			}			
			
			_gui.getTreePanel().rebuildPointBranch(getCurrentSelectedPoint2(), listOfSceneLabels);
			_gui.getTreePanel().selectPoint(point2Swap);
		}
		
		private function fillPointGUI(indexPoint:uint):void
		{
			var pointTranslation:Number3D;
			var label:String;
			
			pointTranslation = _ctrMain.ctrPoint.getPosition(indexPoint);
			label = _ctrMain.ctrPoint.getLabel(indexPoint);
			
			_gui.getPointPanel().getJTFPointLabel().setText(label);
			_gui.getPointPanel().getJTFPointTrX().setText(String(pointTranslation.x));
			_gui.getPointPanel().getJTFPointTrY().setText(String(pointTranslation.y));
			_gui.getPointPanel().getJTFPointTrZ().setText(String(pointTranslation.z));
		}
		
		private function fillSceneGUI(indexPoint:uint, indexScene:uint):void
		{
			var label:String;
			var translation:Number3D;
			var rotation:Number3D;
			var scale:Number3D;
			var audioData:AudioScene;
			var videoData:VideoScene;
			var textureData:TextureScene;
			var virtualObjectData:VirtualObjectScene;
			var animationData:AnimationScene;
			
			cleanSceneFields2();
			
			label = _ctrMain.ctrPoint.getCtrScene(indexPoint).getLabel(indexScene);
			translation = _ctrMain.ctrPoint.getCtrScene(indexPoint).getTranslation(indexScene);
			rotation = _ctrMain.ctrPoint.getCtrScene(indexPoint).getRotation(indexScene);
			scale = _ctrMain.ctrPoint.getCtrScene(indexPoint).getScale(indexScene);
			
			virtualObjectData = _ctrMain.ctrPoint.getCtrScene(indexPoint).getVirtualObjectData(indexScene);
			videoData = _ctrMain.ctrPoint.getCtrScene(indexPoint).getVideoData(indexScene);
			textureData = _ctrMain.ctrPoint.getCtrScene(indexPoint).getTextureData(indexScene);
			audioData = _ctrMain.ctrPoint.getCtrScene(indexPoint).getAudioData(indexScene);
			animationData = _ctrMain.ctrPoint.getCtrScene(indexPoint).getAnimationData(indexScene);
			
			_gui.getScenePanel().getJTFSceneLabel().setText(label);
			_gui.getScenePanel().getJTFSceneTrX().setText(String(translation.x));
			_gui.getScenePanel().getJTFSceneTrY().setText(String(translation.y));
			_gui.getScenePanel().getJTFSceneTrZ().setText(String(translation.z));
			_gui.getScenePanel().getJTFSceneRotX().setText(String(rotation.x));
			_gui.getScenePanel().getJTFSceneRotY().setText(String(rotation.y));
			_gui.getScenePanel().getJTFSceneRotZ().setText(String(rotation.z));
			_gui.getScenePanel().getJTFSceneScX().setText(String(scale.x));
			_gui.getScenePanel().getJTFSceneScY().setText(String(scale.y));
			_gui.getScenePanel().getJTFSceneScZ().setText(String(scale.z));
			
			if (animationData)
			{
				_gui.getScenePanel().getAnimationPanel().setHasAnimation(true);
				_gui.getScenePanel().getAnimationPanel().setAnimationPeriod(animationData.getPeriod());
				_gui.getScenePanel().getAnimationPanel().setAnimationRotationAxis(animationData.getRotationAxis());
				_gui.getScenePanel().getAnimationPanel().setAnimationRadius(animationData.getRadius());
				_gui.getScenePanel().getAnimationPanel().setAnimationRotationDirection(animationData.getRotationDirection());
			}
			if (audioData)
			{
				_gui.getScenePanel().getJCBAudio().setSelected(true);
				_gui.getScenePanel().getJTFAudioPath().setEnabled(true);
				_gui.getScenePanel().getJTFAudioPath().setText(audioData.getAudioFilePath());
				_gui.getScenePanel().getJCBAudioRepeat().setEnabled(true);
				_gui.getScenePanel().getJCBAudioRepeat().setSelected(audioData.getRepeatAudio());
				_gui.getScenePanel().getJBAddAudioFile().setEnabled(true);
			}
			
			if (videoData)
			{
				_gui.getScenePanel().getJRBVideo().setSelected(true);
				//radioVideoSelected(null);
				_gui.getScenePanel().getJTFVideoPath().setText(videoData.getVideoFilePath());
				_gui.getScenePanel().getJTFVideoHeight().setEnabled(true);
				_gui.getScenePanel().getJTFVideoHeight().setText(videoData.getHeight().toString());
				_gui.getScenePanel().getJTFVideoWidth().setEnabled(true);
				_gui.getScenePanel().getJTFVideoWidth().setText(videoData.getWidth().toString());
				_gui.getScenePanel().getJCBVideoRepeat().setEnabled(true);
				_gui.getScenePanel().getJCBVideoRepeat().setSelected(videoData.getRepeatVideo());
			}
			else if (textureData)
			{
				_gui.getScenePanel().getJRBTexture().setSelected(true);
				//radioTextureSelected(null);
				_gui.getScenePanel().getJTFTexturePath().setText(textureData.getTextureFilePath());
				_gui.getScenePanel().getJTFTextureHeight().setEnabled(true);
				_gui.getScenePanel().getJTFTextureHeight().setText(textureData.getHeight().toString());
				_gui.getScenePanel().getJTFTextureWidth().setEnabled(true);
				_gui.getScenePanel().getJTFTextureWidth().setText(textureData.getWidth().toString());
			}
			else
			{
				_gui.getScenePanel().getJRB3DObj().setSelected(true);
				//listenerRadioSelect3DObj(null);
				//_gui.getScenePanel().get().setEnabled(true);
				_gui.getScenePanel().getJTF3DObjPath().setText(virtualObjectData.getPath3DObjectFile());
				//_gui.getScenePanel().getBtnObject3dLoad().setEnabled(true);
			}
		}
		
		private function cleanSceneFields2():void
		{
			_gui.getScenePanel().getJTFSceneLabel().setText("");
			_gui.getScenePanel().getJCBAudio().setSelected(false);
			_gui.getScenePanel().getJTFAudioPath().setText("");
			_gui.getScenePanel().getJCBAudioRepeat().setSelected(false);
			
			//disabling audio related buttons
			_gui.getScenePanel().getJBAddAudioFile().setEnabled(false);
			_gui.getScenePanel().getJCBAudioRepeat().setEnabled(false);
			
			_gui.getScenePanel().getJTF3DObjPath().setText("");
			
			_gui.getScenePanel().getJTFVideoPath().setText("");
			_gui.getScenePanel().getJTFVideoWidth().setEnabled(false);
			_gui.getScenePanel().getJTFVideoWidth().setText("");
			_gui.getScenePanel().getJTFVideoHeight().setEnabled(false);
			_gui.getScenePanel().getJTFVideoHeight().setText("");
			_gui.getScenePanel().getJCBVideoRepeat().setEnabled(false);
			_gui.getScenePanel().getJCBVideoRepeat().setSelected(false);
			
			_gui.getScenePanel().getJTFTexturePath().setText("");
			_gui.getScenePanel().getJTFTextureWidth().setEnabled(false);
			_gui.getScenePanel().getJTFTextureWidth().setText("");
			_gui.getScenePanel().getJTFTextureHeight().setEnabled(false);
			_gui.getScenePanel().getJTFTextureHeight().setText("");
		
			_gui.getScenePanel().getAnimationPanel().setHasAnimation(false);
			_gui.getScenePanel().getAnimationPanel().setAnimationRotationAxis(ViewAnimationScene.X_ROTATION_AXIS);
			_gui.getScenePanel().getAnimationPanel().setAnimationPeriod(10);
			_gui.getScenePanel().getAnimationPanel().setAnimationRadius(0);
			_gui.getScenePanel().getAnimationPanel().setAnimationRotationDirection(1);
		}
		
		public function listenerAudioSelected(e:Event):void
		{
			//if the has audio checkbox was marked
			if (_gui.getScenePanel().getJCBAudio().isSelected())
			{
				setEnabledAudioPropertiesFields2(true);
			}
			//if the has audio checkbox was unmarked
			else
			{
				var audioData:AudioScene;
				audioData = _ctrMain.ctrPoint.getCtrScene(getCurrentSelectedPoint2()).getAudioData(getCurrentSelectedScene2());
				
				if (audioData)
				{
					_ctrMain.ctrPoint.getCtrScene(getCurrentSelectedPoint2()).updateRemoveAudio(getCurrentSelectedScene2());
				}
				_gui.getScenePanel().getJTFAudioPath().setText("");
				_gui.getScenePanel().getJCBAudioRepeat().setSelected(false);
				_gui.getScenePanel().getJCBAudioRepeat().setEnabled(false);
				setEnabledAudioPropertiesFields2(false);
			}
		}
		
		public function listenerRadioSelect3DObj(e:Event):void
		{
			if (_gui.getScenePanel().getTabType().remove(_gui.getScenePanel().getTexturePanel()) || _gui.getScenePanel().getTabType().remove(_gui.getScenePanel().getVideoPanel()))
			{
				_gui.getScenePanel().getTabType().append(_gui.getScenePanel().get3DObjPanel(), BorderLayout.CENTER);
			}
		}
		
		public function listenerRadioSelectTexture(e:Event):void
		{
			if (_gui.getScenePanel().getTabType().remove(_gui.getScenePanel().get3DObjPanel()) || _gui.getScenePanel().getTabType().remove(_gui.getScenePanel().getVideoPanel()))
			{
				_gui.getScenePanel().getTabType().append(_gui.getScenePanel().getTexturePanel(), BorderLayout.CENTER);
			}
		}
		
		public function listenerRadioSelectVideo(e:Event):void
		{
			if (_gui.getScenePanel().getTabType().remove(_gui.getScenePanel().getTexturePanel()) || _gui.getScenePanel().getTabType().remove(_gui.getScenePanel().get3DObjPanel()))
			{
				_gui.getScenePanel().getTabType().append(_gui.getScenePanel().getVideoPanel(), BorderLayout.CENTER);
			}
		}
		
		private function setEnabledAudioPropertiesFields2(enabled:Boolean):void
		{
			_gui.getScenePanel().getJBAddAudioFile().setEnabled(enabled);
			_gui.getScenePanel().getJTFAudioPath().setEnabled(enabled);
		}
		
		public function getCurrentSelectedPoint2():uint
		{
			return _gui.getTreePanel().getCurrentSelectedPoint();
		}
		
		public function getCurrentSelectedScene2():uint
		{
			return _gui.getTreePanel().getCurrentSelectedScene();
		}
	}
}