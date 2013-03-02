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
	import flaras.model.util.*;
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
		}
		
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
					_ctrMain.ctrPoint.getCtrScene(getCurrentSelectedPoint2()).addScene(pFilePath, Number3D.ZERO,
						Number3D.ZERO, new Number3D(1, 1, 1), false, "", 0, 0, false, "", false, false,
						"", 0, 0, false, false, 0, 0, 0, 0, 0, "", Number3D.ZERO, 0, false, "");
				}
				if (pCopyDestination == FolderConstants.TEXTURE_FOLDER)
				{
					_ctrMain.ctrPoint.getCtrScene(getCurrentSelectedPoint2()).addScene("", Number3D.ZERO,
						Number3D.ZERO, new Number3D(1, 1, 1), true, pFilePath, GeneralConstants.TEXTURE_DEFAULT_WIDTH,
						GeneralConstants.TEXTURE_DEFAULT_HEIGHT, false, "", false, false, "", 0, 0, false,
						false, 0, 0, 0, 0, 0, "", Number3D.ZERO, 0, false, "");
				}
				if (pCopyDestination == FolderConstants.VIDEO_FOLDER)
				{
					_ctrMain.ctrPoint.getCtrScene(getCurrentSelectedPoint2()).addScene("", Number3D.ZERO,
						Number3D.ZERO, new Number3D(1, 1, 1), false, "", 0, 0, false, "", false, true,
						pFilePath, GeneralConstants.VIDEO_DEFAULT_WIDTH, GeneralConstants.VIDEO_DEFAULT_HEIGHT,
						false, false, 0, 0, 0, 0, 0, "", Number3D.ZERO, 0, false, "");
				}
				
				_gui.getTreePanel().addScene(getCurrentSelectedPoint2());
				_gui.getTreePanel().selectScene(getCurrentSelectedPoint2(), indexNewScene);
			}
			//update on scene
			else
			{
				if (pCopyDestination == FolderConstants.AUDIO_FOLDER)
				{
					_ctrMain.ctrPoint.getCtrScene(getCurrentSelectedPoint2()).updateAddAudio(getCurrentSelectedScene2(),
						pFilePath, _gui.getScenePanel().getJCBAudioRepeat().isSelected());
					_gui.getScenePanel().getJTFAudioPath().setText(pFilePath);
					_gui.getScenePanel().getJCBAudioRepeat().setEnabled(true);
				}
				else
				{
					if (pCopyDestination == FolderConstants.COLLADA_FOLDER)
					{
						_ctrMain.ctrPoint.getCtrScene(getCurrentSelectedPoint2()).updateRebuildScene(getCurrentSelectedScene2(),
							pFilePath, new Number3D(new Number(_gui.getScenePanel().getJTFSceneTrX().getText()),
							new Number(_gui.getScenePanel().getJTFSceneTrY().getText()), new Number(_gui.getScenePanel().getJTFSceneTrZ().getText())),
							new Number3D(new Number(_gui.getScenePanel().getJTFSceneRotX().getText()),
							new Number(_gui.getScenePanel().getJTFSceneRotY().getText()), new Number(_gui.getScenePanel().getJTFSceneRotZ().getText())),
							new Number3D(new Number(_gui.getScenePanel().getJTFSceneScX().getText()),
							new Number(_gui.getScenePanel().getJTFSceneScY().getText()), new Number(_gui.getScenePanel().getJTFSceneScZ().getText())),
							false, "", 0, 0, _gui.getScenePanel().getJCBAudio().isSelected(), _gui.getScenePanel().getJTFAudioPath().getText(),
							_gui.getScenePanel().getJCBAudioRepeat().isSelected(), false, "", 0, 0, false,
							_gui.getScenePanel().getAnimationPanel().getHasAnimation(), Number(_gui.getScenePanel().getAnimationPanel().getWindowCircularAnimation().getJTFRotationPeriod().getText()),
							_gui.getScenePanel().getAnimationPanel().getWindowCircularAnimation().getAnimationRotationAxis(), Number(_gui.getScenePanel().getAnimationPanel().getWindowCircularAnimation().getJTFRotationRadiusA().getText()),
							Number(_gui.getScenePanel().getAnimationPanel().getWindowCircularAnimation().getJTFRotationRadiusB().getText()), _gui.getScenePanel().getAnimationPanel().getWindowCircularAnimation().getAnimationDirection(), 
							_gui.getScenePanel().getAnimationPanel().getAnimationType(),
							_gui.getScenePanel().getAnimationPanel().getWindowP2PAnimation().getDisplacement(), _gui.getScenePanel().getAnimationPanel().getWindowP2PAnimation().getTime(), _gui.getScenePanel().getAnimationPanel().getWindowP2PAnimation().hasLoop(),
							_gui.getScenePanel().getJTFSceneLabel().getText());
					}
					else if (pCopyDestination == FolderConstants.TEXTURE_FOLDER)
					{
						_ctrMain.ctrPoint.getCtrScene(getCurrentSelectedPoint2()).updateRebuildScene(getCurrentSelectedScene2(),
							"", new Number3D(new Number(_gui.getScenePanel().getJTFSceneTrX().getText()),
							new Number(_gui.getScenePanel().getJTFSceneTrY().getText()), new Number(_gui.getScenePanel().getJTFSceneTrZ().getText())),
							new Number3D(new Number(_gui.getScenePanel().getJTFSceneRotX().getText()),
							new Number(_gui.getScenePanel().getJTFSceneRotY().getText()), new Number(_gui.getScenePanel().getJTFSceneRotZ().getText())),
							new Number3D(new Number(_gui.getScenePanel().getJTFSceneScX().getText()),
							new Number(_gui.getScenePanel().getJTFSceneScY().getText()), new Number(_gui.getScenePanel().getJTFSceneScZ().getText())),
							true, pFilePath, GeneralConstants.TEXTURE_DEFAULT_WIDTH, GeneralConstants.TEXTURE_DEFAULT_HEIGHT,
							_gui.getScenePanel().getJCBAudio().isSelected(), _gui.getScenePanel().getJTFAudioPath().getText(),
							_gui.getScenePanel().getJCBAudioRepeat().isSelected(), false, "", 0, 0, false,
							_gui.getScenePanel().getAnimationPanel().getHasAnimation(), Number(_gui.getScenePanel().getAnimationPanel().getWindowCircularAnimation().getJTFRotationPeriod().getText()),
							_gui.getScenePanel().getAnimationPanel().getWindowCircularAnimation().getAnimationRotationAxis(), Number(_gui.getScenePanel().getAnimationPanel().getWindowCircularAnimation().getJTFRotationRadiusA().getText()),
							Number(_gui.getScenePanel().getAnimationPanel().getWindowCircularAnimation().getJTFRotationRadiusB().getText()), _gui.getScenePanel().getAnimationPanel().getWindowCircularAnimation().getAnimationDirection(), 
							_gui.getScenePanel().getAnimationPanel().getAnimationType(),
							_gui.getScenePanel().getAnimationPanel().getWindowP2PAnimation().getDisplacement(), _gui.getScenePanel().getAnimationPanel().getWindowP2PAnimation().getTime(), _gui.getScenePanel().getAnimationPanel().getWindowP2PAnimation().hasLoop(),
							_gui.getScenePanel().getJTFSceneLabel().getText());
					}
					else
					{
						_ctrMain.ctrPoint.getCtrScene(getCurrentSelectedPoint2()).updateRebuildScene(getCurrentSelectedScene2(),
							"", new Number3D(new Number(_gui.getScenePanel().getJTFSceneTrX().getText()),
							new Number(_gui.getScenePanel().getJTFSceneTrZ().getText()), new Number(_gui.getScenePanel().getJTFSceneTrZ().getText())),
							new Number3D(new Number(_gui.getScenePanel().getJTFSceneRotX().getText()),
							new Number(_gui.getScenePanel().getJTFSceneRotY().getText()), new Number(_gui.getScenePanel().getJTFSceneRotZ().getText())),
							new Number3D(new Number(_gui.getScenePanel().getJTFSceneScX().getText()),
							new Number(_gui.getScenePanel().getJTFSceneScY().getText()), new Number(_gui.getScenePanel().getJTFSceneScZ().getText())),
							false, "", 0, 0, _gui.getScenePanel().getJCBAudio().isSelected(), _gui.getScenePanel().getJTFAudioPath().getText(),
							_gui.getScenePanel().getJCBAudioRepeat().isSelected(), true, pFilePath, GeneralConstants.VIDEO_DEFAULT_WIDTH,
							GeneralConstants.VIDEO_DEFAULT_HEIGHT, false, _gui.getScenePanel().getAnimationPanel().getHasAnimation(), Number(_gui.getScenePanel().getAnimationPanel().getWindowCircularAnimation().getJTFRotationPeriod().getText()),
							_gui.getScenePanel().getAnimationPanel().getWindowCircularAnimation().getAnimationRotationAxis(), Number(_gui.getScenePanel().getAnimationPanel().getWindowCircularAnimation().getJTFRotationRadiusA().getText()),
							Number(_gui.getScenePanel().getAnimationPanel().getWindowCircularAnimation().getJTFRotationRadiusB().getText()), _gui.getScenePanel().getAnimationPanel().getWindowCircularAnimation().getAnimationDirection(), 
							_gui.getScenePanel().getAnimationPanel().getAnimationType(),
							_gui.getScenePanel().getAnimationPanel().getWindowP2PAnimation().getDisplacement(), _gui.getScenePanel().getAnimationPanel().getWindowP2PAnimation().getTime(), _gui.getScenePanel().getAnimationPanel().getWindowP2PAnimation().hasLoop(),
							_gui.getScenePanel().getJTFSceneLabel().getText());
					}
					fillSceneGUI(getCurrentSelectedPoint2(), getCurrentSelectedScene2());
				}
			}
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
		
		public function resetInterface():void
		{		
			_gui.getTreePanel().resetTree();
		}
		
		public function initProjectTree():void
		{
			_gui.getTreePanel().initTree(_ctrMain.ctrPoint.getListOfPoints());
		}
		
		public function audioLoad(e:Event):void
		{
			FileCopy.audioCopy(_ctrMain.ctrUserProject.getCurrentProjectTempFolder(), this);
		}
		
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
		
		public function actionPointAttractionRepulsionSelected():void
		{
			var indexPoint:uint;
			
			indexPoint = getCurrentSelectedPoint2();
			_ctrMain.ctrPoint.disableAllPointsUI();
			_ctrMain.ctrPoint.enablePointUI(indexPoint);
			fillPointAttractionRepulsionGUI(indexPoint);			
		}
		
		public function actionSceneSelected():void
		{
			_ctrMain.ctrPoint.disableAllPointsUI();
			_ctrMain.ctrPoint.enablePointUI(getCurrentSelectedPoint2());
			_ctrMain.ctrPoint.getCtrScene(getCurrentSelectedPoint2()).resetAllScenesPosition();
			_ctrMain.ctrPoint.goToScene(getCurrentSelectedPoint2(), getCurrentSelectedScene2());			
			fillSceneGUI(getCurrentSelectedPoint2(), getCurrentSelectedScene2());
		}
		
		public function listenerAddPoint(e:Event):void
		{
			_ctrMain.ctrPoint.addPoint(Number3D.ZERO, "", false);
			_gui.getTreePanel().addPoint();
			_gui.getTreePanel().selectPoint(_ctrMain.ctrPoint.getNumberOfPoints() - 1);
		}
		
		public function listenerAddPointAttractRepulse(e:Event):void
		{
			_ctrMain.ctrPoint.addPointAttractRepulse(Number3D.ZERO, "", 50, -1,  false);
			_gui.getTreePanel().addPointAttractRepulse();
			_gui.getTreePanel().selectPoint(_ctrMain.ctrPoint.getNumberOfPoints() -1);
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
			if (_gui.getTreePanel().getSelectedPointType() == ViewGUIProjectTree.TYPE_POINT)
			{
				label = _gui.getPointPanel().getJTFPointLabel().getText();
				
			}
			else
			{
				//if it's an attraction/repulsion point
				label = _gui.getPointAttractionRepulsionPanel().getJTFPointLabel().getText();				
			}	
			
			_ctrMain.ctrPoint.updatePointLabel(getCurrentSelectedPoint2(), label);
			_gui.getTreePanel().updatePointLabel(label);
		}
		
		public function listenerUpdateMoveInteractionForScenes(e:Event):void
		{
			var moveInteractionForScenes:Boolean;
			
			moveInteractionForScenes = _gui.getPointPanel().getJCBMoveInteractionForScenes().isSelected();
			
			_ctrMain.ctrPoint.updatePointMoveInteractionForScenes(getCurrentSelectedPoint2(), moveInteractionForScenes);
		}
		
		public function listenerUpdatePointPosition(e:Event):void
		{
			var indexPoint:uint;
			var x:Number;
			var y:Number;
			var z:Number;
			
			indexPoint = getCurrentSelectedPoint2();
			if (_gui.getTreePanel().getSelectedPointType() == ViewGUIProjectTree.TYPE_POINT)
			{
				x = Number(_gui.getPointPanel().getJTFPointTrX().getText());
				y = Number(_gui.getPointPanel().getJTFPointTrY().getText());
				z = Number(_gui.getPointPanel().getJTFPointTrZ().getText());
			}
			else
			{
				x = Number(_gui.getPointAttractionRepulsionPanel().getJTFPointTrX().getText());
				y = Number(_gui.getPointAttractionRepulsionPanel().getJTFPointTrY().getText());
				z = Number(_gui.getPointAttractionRepulsionPanel().getJTFPointTrZ().getText());
			}
			
			_ctrMain.ctrPoint.updatePointPosition(indexPoint, new Number3D(x, y, z));
		}
		
		public function listenerUpdateAttractionSphereRadius(e:Event):void
		{
			var indexPoint:uint;
			var radius:Number;
			
			indexPoint = getCurrentSelectedPoint2();
			
			radius = parseFloat(_gui.getPointAttractionRepulsionPanel().getJTFAttractionSphereRadius().getText());
			_ctrMain.ctrPoint.updateAttractionSphereRadius(indexPoint, radius);
		}
		
		public function actionAddRefScene2Attract(indexPoint:uint, indexScene:uint):void
		{
			var pointLabel:String;
			var sceneLabel:String;
			
			var pointIDNumber:uint;
			var sceneIDNumber:uint;
			
			pointLabel = getCtrMain().ctrPoint.getLabel(indexPoint);
			sceneLabel = getCtrMain().ctrPoint.getCtrScene(indexPoint).getLabel(indexScene);
			
			pointIDNumber = getCtrMain().ctrPoint.getIDNumber(indexPoint);
			sceneIDNumber = getCtrMain().ctrPoint.getCtrScene(indexPoint).getIDNumber(indexScene);
			
			//if the scene is already on the list of scenes to attract
			if (_ctrMain.ctrPoint.isSceneOnAttractionList(getCurrentSelectedPoint2(), pointIDNumber, sceneIDNumber))
			{
				MessageWindow.messageSceneAlreadyOnAttractList();
			}
			else
			{
				//if the scene is not on the list of scenes to attract
				_gui.getPointAttractionRepulsionPanel().setVisibleWindowSelectScene(false);
				getCtrMain().ctrPoint.updateAddScene2AttractList(getCurrentSelectedPoint2(), pointIDNumber, sceneIDNumber);
				_gui.getPointAttractionRepulsionPanel().addRefScene2JList(indexPoint, pointLabel, indexScene, sceneLabel);
			}		
		}
		
		public function listenerRemovePoint(e:Event):void
		{
			JOptionPane.showMessageDialog("Confirmation", "Are you sure about deleting this point?\nAll child scenes will also be deleted.",
				null, null, true, new LoadIcon("icons/external/warning.png", 48, 48), JOptionPane.YES + JOptionPane.NO).getYesButton().addActionListener(listenerConfirmedRemovePoint);
		}
		
		public function listenerConfirmedRemovePoint(e:Event):void
		{
			_ctrMain.ctrPoint.removePoint(getCurrentSelectedPoint2());
			_gui.getTreePanel().removePoint(getCurrentSelectedPoint2(), _ctrMain.ctrPoint.getListOfPoints());
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
			var strX:String;
			var strY:String;
			var strZ:String;
			var allFieldsValid:Boolean;
			var vectFieldData:Vector.<FieldData>;
			
			strX = _gui.getScenePanel().getJTFSceneTrX().getText();
			strY = _gui.getScenePanel().getJTFSceneTrY().getText();
			strZ = _gui.getScenePanel().getJTFSceneTrZ().getText();
			
			vectFieldData = new Vector.<FieldData>();
			vectFieldData.push(new FieldData("Translation X", strX));
			vectFieldData.push(new FieldData("Translation Y", strY));
			vectFieldData.push(new FieldData("Translation Z", strZ));
			
			allFieldsValid = generalNumericFieldValidator(vectFieldData);
			
			if (allFieldsValid)
			{
				_ctrMain.ctrPoint.getCtrScene(getCurrentSelectedPoint2()).updateTranslation(getCurrentSelectedScene2(),
					new Number3D(Number(strX), Number(strY), Number(strZ)));
			}
		}
		
		public function listenerUpdateSceneRotation(e:Event):void
		{
			var strRotX:String;
			var strRotY:String;
			var strRotZ:String;
			var allFieldsValid:Boolean;
			var vectFieldData:Vector.<FieldData>;
			
			strRotX = _gui.getScenePanel().getJTFSceneRotX().getText()
			strRotY = _gui.getScenePanel().getJTFSceneRotY().getText()
			strRotZ = _gui.getScenePanel().getJTFSceneRotZ().getText()
			
			vectFieldData = new Vector.<FieldData>();
			vectFieldData.push(new FieldData("Rotation X", strRotX));
			vectFieldData.push(new FieldData("Rotation Y", strRotY));
			vectFieldData.push(new FieldData("Rotation Z", strRotZ));
			
			allFieldsValid = generalNumericFieldValidator(vectFieldData);
			
			if (allFieldsValid)
			{
				_ctrMain.ctrPoint.getCtrScene(getCurrentSelectedPoint2()).updateRotation(getCurrentSelectedScene2(),
					new Number3D(Number(strRotX), Number(strRotY), Number(strRotZ)));
			}
		}
		
		public function listenerUpdateSceneScale(e:Event):void
		{
			var strScX:String;
			var strScY:String;
			var strScZ:String;
			var allFieldsValid:Boolean;
			var vectFieldData:Vector.<FieldData>;
			
			strScX = _gui.getScenePanel().getJTFSceneScX().getText();
			strScY = _gui.getScenePanel().getJTFSceneScY().getText();
			strScZ = _gui.getScenePanel().getJTFSceneScZ().getText();
			
			vectFieldData = new Vector.<FieldData>();
			vectFieldData.push(new FieldData("Scale X", strScX));
			vectFieldData.push(new FieldData("Scale Y", strScY));
			vectFieldData.push(new FieldData("Scale Z", strScZ));
			
			allFieldsValid = generalNumericFieldValidator(vectFieldData);
			
			if (allFieldsValid)
			{
				_ctrMain.ctrPoint.getCtrScene(getCurrentSelectedPoint2()).updateScale(getCurrentSelectedScene2(),
					new Number3D(Number(strScX), Number(strScY), Number(strScZ)));
			}
		}
		
		private function generalNumericFieldValidator(vectFieldData:Vector.<FieldData>):Boolean
		{
			var fieldData:FieldData;
			var fieldName:String;
			var fieldValue:String;
			var numericValue:Number;
			var allFieldsHaveValidNumbers:Boolean;
			
			allFieldsHaveValidNumbers = true;
			
			for (var i:uint = 0; i < vectFieldData.length; i++)
			{
				fieldData = vectFieldData[i];
				fieldName = fieldData.getName();
				fieldValue = fieldData.getValue();
				
				numericValue = Number(fieldValue);
				if (isNaN(numericValue))
				{
					MessageWindow.messageWarningField(fieldValue, fieldName);
					allFieldsHaveValidNumbers = false;
				}
			}
			
			return allFieldsHaveValidNumbers;
		}
		
		public function listenerUpdateSceneLabel(e:Event):void
		{
			var label:String;
			
			label = _gui.getScenePanel().getJTFSceneLabel().getText();
			_ctrMain.ctrPoint.getCtrScene(getCurrentSelectedPoint2()).updateLabel(getCurrentSelectedScene2(),
				label);
			_gui.getTreePanel().updateSceneLabel(label);
		}
		
		public function listenerUpdateSceneTextureSize(e:Event):void
		{
			var strWidth:String;
			var strHeight:String;
			var allFieldsValid:Boolean;
			var vectFieldData:Vector.<FieldData>;
			
			strWidth = _gui.getScenePanel().getJTFTextureWidth().getText();
			strHeight = _gui.getScenePanel().getJTFTextureHeight().getText();
			
			vectFieldData = new Vector.<FieldData>();
			vectFieldData.push(new FieldData("Texture Width", strWidth));
			vectFieldData.push(new FieldData("Texture Height", strHeight));
			
			allFieldsValid = generalNumericFieldValidator(vectFieldData);
			
			if (allFieldsValid)
			{
				_ctrMain.ctrPoint.getCtrScene(getCurrentSelectedPoint2()).updateTextureSize(getCurrentSelectedScene2(),
					Number(strWidth), Number(strHeight));
			}
		}
		
		public function listenerUpdateSceneVideoSize(e:Event):void
		{
			var strWidth:String;
			var strHeight:String;
			var allFieldsValid:Boolean;
			var vectFieldData:Vector.<FieldData>;
			
			strWidth = _gui.getScenePanel().getJTFVideoWidth().getText();
			strHeight = _gui.getScenePanel().getJTFVideoHeight().getText();
			
			vectFieldData = new Vector.<FieldData>();
			vectFieldData.push(new FieldData("Video Width", strWidth));
			vectFieldData.push(new FieldData("Video Height", strHeight));
			
			allFieldsValid = generalNumericFieldValidator(vectFieldData);			
			
			if (allFieldsValid)
			{
				_ctrMain.ctrPoint.getCtrScene(getCurrentSelectedPoint2()).updateVideoSize(getCurrentSelectedScene2(),
					Number(strWidth), Number(strHeight));
			}
		}
		
		public function listenerUpdateVideoRepeat(e:Event):void
		{
			_ctrMain.ctrPoint.getCtrScene(getCurrentSelectedPoint2()).updateVideoRepeat(getCurrentSelectedScene2(),
				_gui.getScenePanel().getJCBVideoRepeat().isSelected());
		}
		
		public function listenerAddAudio(e:Event):void
		{
			FileCopy.audioCopy(_ctrMain.ctrUserProject.getCurrentProjectTempFolder(), this);
		}
		
		public function listenerUpdateAudioRepeat(e:Event):void
		{
			_ctrMain.ctrPoint.getCtrScene(getCurrentSelectedPoint2()).updateAudioRepeat(getCurrentSelectedScene2(),
				_gui.getScenePanel().getJCBAudioRepeat().isSelected());
		}
		
		public function listenerUpdateAnimationState(newState:Boolean):void
		{
			if (newState)
			{
				if (_gui.getScenePanel().getAnimationPanel().getAnimationType().indexOf(AnimationScene.TYPE_CIRCULAR) != -1)
				{
					addCircularAnimation();
				}
				else
				{
					addP2PAnimation();
				}
			}
			else
			{
				_ctrMain.ctrPoint.getCtrScene(getCurrentSelectedPoint2()).updateRemoveAnimation(getCurrentSelectedScene2());
			}
		}
		
		private function addCircularAnimation():void
		{
			_ctrMain.ctrPoint.getCtrScene(getCurrentSelectedPoint2()).updateAddCircularAnimation(getCurrentSelectedScene2(),
						Number(_gui.getScenePanel().getAnimationPanel().getWindowCircularAnimation().getJTFRotationPeriod().getText()),
						_gui.getScenePanel().getAnimationPanel().getWindowCircularAnimation().getAnimationRotationAxis(), Number(_gui.getScenePanel().getAnimationPanel().getWindowCircularAnimation().getJTFRotationRadiusA().getText()),
						Number(_gui.getScenePanel().getAnimationPanel().getWindowCircularAnimation().getJTFRotationRadiusB().getText()), _gui.getScenePanel().getAnimationPanel().getWindowCircularAnimation().getAnimationDirection());
		}
		
		private function addP2PAnimation():void
		{
			_ctrMain.ctrPoint.getCtrScene(getCurrentSelectedPoint2()).updateAddP2PAnimation(getCurrentSelectedScene2(), 
												_gui.getScenePanel().getAnimationPanel().getWindowP2PAnimation().getDisplacement(),
												_gui.getScenePanel().getAnimationPanel().getWindowP2PAnimation().getTime(), 
												_gui.getScenePanel().getAnimationPanel().getWindowP2PAnimation().hasLoop());
		}
		
		public function listenerChangeAnimationType(e:Event):void
		{
			_ctrMain.ctrPoint.getCtrScene(getCurrentSelectedPoint2()).updateRemoveAnimation(getCurrentSelectedScene2());
			
			//changed from point to point animation to circular animation
			if (_gui.getScenePanel().getAnimationPanel().getAnimationType().indexOf(AnimationScene.TYPE_CIRCULAR) != -1)
			{
				addCircularAnimation();
			}
			//changed from circular animation to point to point animation
			else
			{
				addP2PAnimation();
			}			
		}
		
		public function listenerUpdateCircularAnimationProperties(e:Event):void
		{
			var strRadiusA:String;
			var strRadiusB:String;
			var strPeriod:String;
			var allFieldsValid:Boolean;
			var vectFieldData:Vector.<FieldData>;
			
			strRadiusA = _gui.getScenePanel().getAnimationPanel().getWindowCircularAnimation().getJTFRotationRadiusA().getText();
			strPeriod = _gui.getScenePanel().getAnimationPanel().getWindowCircularAnimation().getJTFRotationPeriod().getText();
			strRadiusB = _gui.getScenePanel().getAnimationPanel().getWindowCircularAnimation().getJTFRotationRadiusB().getText();
			
			vectFieldData = new Vector.<FieldData>();
			vectFieldData.push(new FieldData("Radius A", strRadiusA));
			vectFieldData.push(new FieldData("Radius B", strRadiusB));
			vectFieldData.push(new FieldData("Period", strPeriod));			
			
			allFieldsValid = generalNumericFieldValidator(vectFieldData);
			
			if (allFieldsValid)
			{
				_ctrMain.ctrPoint.getCtrScene(getCurrentSelectedPoint2()).updateCircularAnimationProperties(getCurrentSelectedScene2(),
					Number(strPeriod), _gui.getScenePanel().getAnimationPanel().getWindowCircularAnimation().getAnimationRotationAxis(),
					Number(strRadiusA), Number(strRadiusB), _gui.getScenePanel().getAnimationPanel().getWindowCircularAnimation().getAnimationDirection());
			}
		}
		
		public function listenerUpdateP2PAnimationProperties(e:Event):void
		{
			var destX:String;
			var destY:String;
			var destZ:String;
		
			var time:String;
			var allFieldsValid:Boolean;
			var vectFieldData:Vector.<FieldData>;
			
			destX = _gui.getScenePanel().getAnimationPanel().getWindowP2PAnimation().getJTFDestX().getText();
			destY = _gui.getScenePanel().getAnimationPanel().getWindowP2PAnimation().getJTFDestY().getText();
			destZ = _gui.getScenePanel().getAnimationPanel().getWindowP2PAnimation().getJTFDestZ().getText();
			
			time = _gui.getScenePanel().getAnimationPanel().getWindowP2PAnimation().getJTFTime().getText();
			
			vectFieldData = new Vector.<FieldData>();
			vectFieldData.push(new FieldData("Displacement on x axis", destX));
			vectFieldData.push(new FieldData("Destination on y axis", destY));
			vectFieldData.push(new FieldData("Destination on z axis", destZ));
			vectFieldData.push(new FieldData("Time", time));
			
			allFieldsValid = generalNumericFieldValidator(vectFieldData);
			
			if (allFieldsValid)
			{
				_ctrMain.ctrPoint.getCtrScene(getCurrentSelectedPoint2()).updateP2PAnimationProperties(getCurrentSelectedScene2(), 
											_gui.getScenePanel().getAnimationPanel().getWindowP2PAnimation().getDisplacement(), 
											_gui.getScenePanel().getAnimationPanel().getWindowP2PAnimation().getTime(), 
											_gui.getScenePanel().getAnimationPanel().getWindowP2PAnimation().hasLoop());
			}
		}
		
		public function listenerRemoveScene(e:Event):void
		{
			JOptionPane.showMessageDialog("Confirmation", "Are you sure about deleting this scene?",
				null, null, true, new LoadIcon("icons/external/warning.png", 48, 48), JOptionPane.YES + JOptionPane.NO).getYesButton().addActionListener(listenerConfirmedRemoveScene);
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
			_ctrMain.ctrPoint.getCtrScene(getCurrentSelectedPoint2()).swapScenePositionTo(getCurrentSelectedScene2(),
				pos2Swap - 1);
			listOfSceneLabels = new Vector.<String>();
			for (var i:uint = 0; i < _ctrMain.ctrPoint.getCtrScene(getCurrentSelectedPoint2()).getNumberOfScenes(); i++)
			{
				listOfSceneLabels.push(_ctrMain.ctrPoint.getCtrScene(getCurrentSelectedPoint2()).getLabel(i));
			}
			
			_gui.getTreePanel().rebuildPointBranch(getCurrentSelectedPoint2(), listOfSceneLabels);
			_gui.getTreePanel().selectPoint(point2Swap);
		}
		
		public function listenerCloneScene(e:Event):void
		{
			var indexNewScene:uint;
			var clone:FlarasScene;
			var sourceScene:uint;
			
			sourceScene = getCurrentSelectedScene2();
			indexNewScene = _ctrMain.ctrPoint.getCtrScene(getCurrentSelectedPoint2()).getNumberOfScenes();
			clone = _ctrMain.ctrPoint.getCtrScene(getCurrentSelectedPoint2()).cloneScene(getCurrentSelectedScene2());
			
			_gui.getTreePanel().addScene(getCurrentSelectedPoint2());
			_gui.getTreePanel().selectScene(getCurrentSelectedPoint2(), indexNewScene);
			_gui.getTreePanel().updateSceneLabel(clone.getLabel());
			_gui.getTreePanel().selectScene(getCurrentSelectedPoint2(), sourceScene);
		}
		
		
		private function fillPointGUI(indexPoint:uint):void
		{
			var pointTranslation:Number3D;
			var label:String;
			var moveInteractionForScenes:Boolean;
			
			pointTranslation = _ctrMain.ctrPoint.getPosition(indexPoint);
			label = _ctrMain.ctrPoint.getLabel(indexPoint);
			moveInteractionForScenes = _ctrMain.ctrPoint.getMoveInteractionForScenes(indexPoint);
			
			_gui.getPointPanel().getJTFPointLabel().setText(label);
			_gui.getPointPanel().getJTFPointTrX().setText(String(pointTranslation.x));
			_gui.getPointPanel().getJTFPointTrY().setText(String(pointTranslation.y));
			_gui.getPointPanel().getJTFPointTrZ().setText(String(pointTranslation.z));
			_gui.getPointPanel().getJCBMoveInteractionForScenes().setSelected(moveInteractionForScenes);
		}
		
		private function fillPointAttractionRepulsionGUI(indexPoint:uint):void
		{
			var pointTranslation:Number3D;
			var label:String;
			var objAttractionRepulsionPoint:AttractionRepulsionPoint;
			
			pointTranslation = _ctrMain.ctrPoint.getPosition(indexPoint);
			label = _ctrMain.ctrPoint.getLabel(indexPoint);
			
			_gui.getPointAttractionRepulsionPanel().getJTFPointLabel().setText(label);
			_gui.getPointAttractionRepulsionPanel().getJTFPointTrX().setText(String(pointTranslation.x));
			_gui.getPointAttractionRepulsionPanel().getJTFPointTrY().setText(String(pointTranslation.y));
			_gui.getPointAttractionRepulsionPanel().getJTFPointTrZ().setText(String(pointTranslation.z));
			
			objAttractionRepulsionPoint = AttractionRepulsionPoint(_ctrMain.ctrPoint.getListOfPoints()[indexPoint]);
			_gui.getPointAttractionRepulsionPanel().getJTFAttractionSphereRadius().setText(String(objAttractionRepulsionPoint.getAttractionSphereRadius()));
			_gui.getPointAttractionRepulsionPanel().fillListOfScenes2Attract(objAttractionRepulsionPoint.getListOfScenes2Attract());
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
			var p2pAnimationData:P2PAnimationScene;
			var circularAnimationData:CircularAnimationScene;
			
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
				
				if (animationData is CircularAnimationScene)
				{
					circularAnimationData = CircularAnimationScene(animationData);
					_gui.getScenePanel().getAnimationPanel().setCircularAnimationType();
					
					_gui.getScenePanel().getAnimationPanel().getWindowCircularAnimation().getJTFRotationPeriod().setText(circularAnimationData.getPeriod()+"");
					_gui.getScenePanel().getAnimationPanel().getWindowCircularAnimation().setAnimationRotationAxis(circularAnimationData.getRotationAxis());
					_gui.getScenePanel().getAnimationPanel().getWindowCircularAnimation().getJTFRotationRadiusA().setText(circularAnimationData.getRadiusA() + "");
					_gui.getScenePanel().getAnimationPanel().getWindowCircularAnimation().getJTFRotationRadiusB().setText(circularAnimationData.getRadiusB() + "");
					if (circularAnimationData.getRadiusA() == circularAnimationData.getRadiusB())
					{
						_gui.getScenePanel().getAnimationPanel().getWindowCircularAnimation().getJCBRadiusBCloneRadiusA().setSelected(true);
					}
					else
					{
						_gui.getScenePanel().getAnimationPanel().getWindowCircularAnimation().getJCBRadiusBCloneRadiusA().setSelected(false);
					}
					
					_gui.getScenePanel().getAnimationPanel().getWindowCircularAnimation().setAnimationRotationDirection(circularAnimationData.getRotationDirection());
				}
				else
				{
					p2pAnimationData = P2PAnimationScene(animationData);
					_gui.getScenePanel().getAnimationPanel().setP2PAnimationType();
					
					_gui.getScenePanel().getAnimationPanel().getWindowP2PAnimation().setDisplacement(p2pAnimationData.getDisplacement());
					_gui.getScenePanel().getAnimationPanel().getWindowP2PAnimation().getJTFTime().setText(p2pAnimationData.getTime()+"");
					_gui.getScenePanel().getAnimationPanel().getWindowP2PAnimation().setLoop(p2pAnimationData.hasLoop());
				}				
			}
			if (audioData)
			{
				_gui.getScenePanel().getJCBAudio().setSelected(true);
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
				_gui.getScenePanel().getJTFTexturePath().setText(textureData.getTextureFilePath());
				_gui.getScenePanel().getJTFTextureHeight().setEnabled(true);
				_gui.getScenePanel().getJTFTextureHeight().setText(textureData.getHeight().toString());
				_gui.getScenePanel().getJTFTextureWidth().setEnabled(true);
				_gui.getScenePanel().getJTFTextureWidth().setText(textureData.getWidth().toString());
			}
			else
			{
				_gui.getScenePanel().getJRB3DObj().setSelected(true);
				_gui.getScenePanel().getJTF3DObjPath().setText(virtualObjectData.getPath3DObjectFile());
			}
		}
		
		private function cleanSceneFields2():void
		{
			_gui.getScenePanel().getJTFSceneLabel().setText("");
			
			_gui.getScenePanel().getJCBAudio().setSelected(false);
			_gui.getScenePanel().getJTFAudioPath().setText("");
			_gui.getScenePanel().getJCBAudioRepeat().setSelected(false);
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
			_gui.getScenePanel().getAnimationPanel().setCircularAnimationType();
			_gui.getScenePanel().getAnimationPanel().getWindowCircularAnimation().setAnimationRotationAxis(ViewCircularAnimationScene.X_ROTATION_AXIS);
			_gui.getScenePanel().getAnimationPanel().getWindowCircularAnimation().getJTFRotationPeriod().setText(10+"");
			_gui.getScenePanel().getAnimationPanel().getWindowCircularAnimation().getJTFRotationRadiusA().setText(0 + "");
			_gui.getScenePanel().getAnimationPanel().getWindowCircularAnimation().getJTFRotationRadiusB().setText(0 + "");
			_gui.getScenePanel().getAnimationPanel().getWindowCircularAnimation().getJCBRadiusBCloneRadiusA().setSelected(true);
			_gui.getScenePanel().getAnimationPanel().getWindowCircularAnimation().setAnimationRotationDirection(1);
			
			_gui.getScenePanel().getAnimationPanel().getWindowP2PAnimation().cleanFields();
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
			_gui.getScenePanel().getJCBAudioRepeat().setEnabled(enabled);
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