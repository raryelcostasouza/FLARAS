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
	import flaras.constants.GeneralConstants;
	import flaras.controller.*;
	import flaras.entity.*;
	import flaras.entity.object3D.*;
	import flaras.io.*;
	import flaras.userInterface.*;
	import flaras.userInterface.graphicUserInterfaceComponents.*;
	import flash.events.*;
	import flash.ui.Keyboard;
	import org.aswing.*;
	import org.papervision3d.core.math.*;
	
	/**
	 * Controlador da Interface Gráfica
	 * @author Hipólito Douglas
	 */
	public class CtrGUI
	{
		private var aControl:CtrInteractionUI;
		private var aGUI:GraphicsUserInterface;
		private var propertiesPanel:PropertiesPanel;
		private var object3dpanel:Object3DPopupPanel;
		private var videopanel:ObjectVideoPopupPanel;
		private var texturepanel:ObjectTexturePopupPanel;
		private var _animationPanel:AnimationPanel;
		
		public function CtrGUI(pControl:CtrInteractionUI, pGui:GraphicsUserInterface) {
			aControl = pControl;
			aGUI = pGui;
		}
		
		public function getGUI():GraphicsUserInterface
		{
			return aGUI;
		}
		
		public function finishedFileCopying(path:String, destiny:String):void {
			aControl.getObjCtrUserProject().setUnsavedModifications(true);
			
			var tempindex:int;
			if (propertiesPanel.getObjList().getSelectedItem() == "New")
			{
				if (destiny == "dae/") 
				{
					tempindex = propertiesPanel.getObjList().getItemCount();
					aControl.getCtrPoint().getCtrListOfObjects(propertiesPanel.getPtList().getSelectedIndex() - 1).addObject(path,
					new Number3D(new Number(propertiesPanel.getObjTrX().getText()), new Number(propertiesPanel.getObjTrY().getText()), new Number(propertiesPanel.getObjTrZ().getText())),
					new Number3D(new Number(propertiesPanel.getObjRtX().getText()), new Number(propertiesPanel.getObjRtY().getText()), new Number(propertiesPanel.getObjRtZ().getText())),
					new Number3D(new Number(propertiesPanel.getObjScX().getText()), new Number(propertiesPanel.getObjScY().getText()), new Number(propertiesPanel.getObjScZ().getText())), 
					false, "", 0, 0, false, "", false, false, "", 0, 0, false, _animationPanel.getHasAnimation(), _animationPanel.getAnimationPeriod(), _animationPanel.getAnimationRotationAxis(),
					_animationPanel.getAnimationRadius(), _animationPanel.getAnimationDirection());
					comboBoxContentsObj(propertiesPanel.getObjList(), aControl.getCtrPoint()
					.getListOfPoints()[propertiesPanel.getPtList().getSelectedIndex() - 1].getListOfObjects());
				}
				if (destiny == "textures/") 
				{
					tempindex = propertiesPanel.getObjList().getItemCount();
					aControl.getCtrPoint().getCtrListOfObjects(propertiesPanel.getPtList().getSelectedIndex() - 1).addObject("",
					new Number3D(new Number(propertiesPanel.getObjTrX().getText()), new Number(propertiesPanel.getObjTrY().getText()), new Number(propertiesPanel.getObjTrZ().getText())),
					new Number3D(new Number(propertiesPanel.getObjRtX().getText()), new Number(propertiesPanel.getObjRtY().getText()), new Number(propertiesPanel.getObjRtZ().getText())),
					new Number3D(new Number(propertiesPanel.getObjScX().getText()), new Number(propertiesPanel.getObjScY().getText()), new Number(propertiesPanel.getObjScZ().getText())),
					true, path, GeneralConstants.TEXTURE_DEFAULT_WIDTH, GeneralConstants.TEXTURE_DEFAULT_HEIGHT, false, "", false, false, "", 0, 0, false, _animationPanel.getHasAnimation(),
					_animationPanel.getAnimationPeriod(), _animationPanel.getAnimationRotationAxis(),
					_animationPanel.getAnimationRadius(), _animationPanel.getAnimationDirection());
					
					comboBoxContentsObj(propertiesPanel.getObjList(), aControl.getCtrPoint()
					.getListOfPoints()[propertiesPanel.getPtList().getSelectedIndex() - 1].getListOfObjects());
				}
				if (destiny == "videos/") 
				{
					tempindex = propertiesPanel.getObjList().getItemCount();
					aControl.getCtrPoint().getCtrListOfObjects(propertiesPanel.getPtList().getSelectedIndex() - 1).addObject("",
					new Number3D(new Number(propertiesPanel.getObjTrX().getText()), new Number(propertiesPanel.getObjTrY().getText()), new Number(propertiesPanel.getObjTrZ().getText())),
					new Number3D(new Number(propertiesPanel.getObjRtX().getText()), new Number(propertiesPanel.getObjRtY().getText()), new Number(propertiesPanel.getObjRtZ().getText())),
					new Number3D(new Number(propertiesPanel.getObjScX().getText()), new Number(propertiesPanel.getObjScY().getText()), new Number(propertiesPanel.getObjScZ().getText())),
					false, "", 0, 0, false, "", false, true, path, GeneralConstants.VIDEO_DEFAULT_WIDTH, GeneralConstants.VIDEO_DEFAULT_HEIGHT, false, _animationPanel.getHasAnimation(),
					_animationPanel.getAnimationPeriod(), _animationPanel.getAnimationRotationAxis(),
					_animationPanel.getAnimationRadius(), _animationPanel.getAnimationDirection());
					comboBoxContentsObj(propertiesPanel.getObjList(), aControl.getCtrPoint()
					.getListOfPoints()[propertiesPanel.getPtList().getSelectedIndex() - 1].getListOfObjects());
					
				}
				propertiesPanel.getObjList().setSelectedIndex(tempindex);
			}
			else 
			{
				var facd3d:FacadeObject3D = new FacadeObject3D(aControl.getCtrPoint().getListOfPoints()[propertiesPanel.getPtList().
				getSelectedIndex() - 1].getListOfObjects()[propertiesPanel.getObjList().getSelectedIndex() - 1]);
				if (destiny == "dae/") 
				{
					aControl.getCtrPoint().getCtrListOfObjects(propertiesPanel.getPtList().getSelectedIndex() - 1).rebuildObject3D(propertiesPanel.getObjList().getSelectedIndex() - 1,
					path, facd3d.getTranslation(), facd3d.getRotation(),
					facd3d.getScale(), false, "", 0, 0, facd3d.hasAudio(), facd3d.getAudioPath(), facd3d.getRepeatAudio(),
					false, "", 0, 0, false, _animationPanel.getHasAnimation(), _animationPanel.getAnimationPeriod(), _animationPanel.getAnimationRotationAxis(), _animationPanel.getAnimationRadius(), _animationPanel.getAnimationDirection());
				}
				if (destiny == "textures/") 
				{
					aControl.getCtrPoint().getCtrListOfObjects(propertiesPanel.getPtList().getSelectedIndex() - 1).rebuildObject3D(propertiesPanel.getObjList().getSelectedIndex() - 1,
					"", facd3d.getTranslation(), facd3d.getRotation(), facd3d.getScale(),
					true, path, GeneralConstants.TEXTURE_DEFAULT_WIDTH, GeneralConstants.TEXTURE_DEFAULT_HEIGHT, facd3d.hasAudio(), facd3d.getAudioPath(), facd3d.getRepeatAudio(), false, "", 0, 0,
					false, _animationPanel.getHasAnimation(), _animationPanel.getAnimationPeriod(), _animationPanel.getAnimationRotationAxis(), _animationPanel.getAnimationRadius(), _animationPanel.getAnimationDirection());
				}
				if (destiny == "videos/") 
				{
					aControl.getCtrPoint().getCtrListOfObjects(propertiesPanel.getPtList().getSelectedIndex() - 1).rebuildObject3D(propertiesPanel.getObjList().getSelectedIndex() - 1,
					"", facd3d.getTranslation(), facd3d.getRotation(), facd3d.getScale(),
					false, "", 0, 0, facd3d.hasAudio(), facd3d.getAudioPath(), facd3d.getRepeatAudio(), true, path, GeneralConstants.VIDEO_DEFAULT_WIDTH, GeneralConstants.VIDEO_DEFAULT_HEIGHT,
					false, _animationPanel.getHasAnimation(), _animationPanel.getAnimationPeriod(), _animationPanel.getAnimationRotationAxis(), _animationPanel.getAnimationRadius(), _animationPanel.getAnimationDirection());
				}
				
				if (destiny == "audios/") 
				{
					var object3d:FacadeObject3D = new FacadeObject3D(aControl.getCtrPoint().getListOfPoints()[propertiesPanel.getPtList().
					getSelectedIndex() - 1].getListOfObjects()[propertiesPanel.getObjList().getSelectedIndex() - 1]);
				
					/*modificações Raryel*/
					aControl.getCtrPoint().getCtrListOfObjects(propertiesPanel.getPtList().getSelectedIndex() - 1).rebuildObject3D(propertiesPanel.getObjList().getSelectedIndex() - 1, 
					object3d.getFilePath(), object3d.getTranslation(), object3d.getRotation(), 
					object3d.getScale(), object3d.hasTexture(), object3d.getTexturePath(), object3d.getTextureWidth(),
					object3d.getTextureHeight(), true, path, propertiesPanel.getAudioRpt().isSelected(), object3d.hasVideo(), object3d.getVideoPath(),
					object3d.getVideoWidth(), object3d.getVideoHeight(), 
					object3d.getRepeatVideo(), _animationPanel.getHasAnimation(), _animationPanel.getAnimationPeriod(), _animationPanel.getAnimationRotationAxis(), _animationPanel.getAnimationRadius(), _animationPanel.getAnimationDirection());
				}				
				propertiesPanel.getObjList().setSelectedIndex(propertiesPanel.getObjList().getSelectedIndex());
				/*fim modificações Raryel*/
			}
			
		}
		
		public function textUpdate(e:Event):void {
			aControl.getObjCtrUserProject().setUnsavedModifications(true);
			
			if (propertiesPanel.getPtList().getSelectedItem() == "New") {	}
			else{
				if (e.currentTarget == propertiesPanel.getPtX() || e.currentTarget == propertiesPanel.getPtY() || e.currentTarget == propertiesPanel.getPtZ()) {
					aControl.getCtrPoint().getListOfPoints()[propertiesPanel.getPtList().getSelectedIndex() - 1].setPosition(new Number3D
					(new Number(propertiesPanel.getPtX().getText()),new Number(propertiesPanel.getPtY().getText()),new Number(propertiesPanel.getPtZ().getText())));
				}
				if (propertiesPanel.getObjList().getSelectedItem() == "New") { }
				else {
					var facade3d:FacadeObject3D = new FacadeObject3D(Point(aControl.getCtrPoint().getListOfPoints()[propertiesPanel.getPtList()
					.getSelectedIndex() - 1]).getListOfObjects()[propertiesPanel.getObjList().getSelectedIndex() - 1]);
					if (e.currentTarget == propertiesPanel.getObjTrX() || e.currentTarget == propertiesPanel.getObjTrY() || e.currentTarget == 
					propertiesPanel.getObjTrZ()) {
						facade3d.setTranslation(new Number3D(new Number(propertiesPanel.getObjTrX().getText()), new Number(propertiesPanel.getObjTrY()
						.getText()), new Number(propertiesPanel.getObjTrZ().getText())));
					}
					if (e.currentTarget == propertiesPanel.getObjRtX() || e.currentTarget == propertiesPanel.getObjRtY() || e.currentTarget == propertiesPanel
					.getObjRtZ()) {
						facade3d.setRotation(new Number3D(new Number(propertiesPanel.getObjRtX().getText()), new Number(propertiesPanel.getObjRtY()
						.getText()), new Number(propertiesPanel.getObjRtZ().getText())));
					}
					if (e.currentTarget == propertiesPanel.getObjScX() || e.currentTarget == propertiesPanel.getObjScY() || e.currentTarget == propertiesPanel
					.getObjScZ()) {
						facade3d.setScale(new Number3D(new Number(propertiesPanel.getObjScX().getText()), new Number(propertiesPanel.getObjScY()
						.getText()), new Number(propertiesPanel.getObjScZ().getText())));
					}
					if (e.currentTarget == videopanel.getObjVideoHeight()||e.currentTarget == videopanel.getObjVideoWidth()) {
						facade3d.setVideoHeight(new Number(videopanel.getObjVideoHeight().getText()));
						facade3d.setVideoWidth(new Number(videopanel.getObjVideoWidth().getText()));
						propertiesPanel.getObjList().setSelectedIndex(propertiesPanel.getObjList().getSelectedIndex());
					}
					if (e.currentTarget == texturepanel.getObjTextureHeight()||e.currentTarget == texturepanel.getObjTextureWidth()) {
						facade3d.setTextureHeight(new Number(texturepanel.getObjTextureHeight().getText()));
						facade3d.setTextureWidth(new Number(texturepanel.getObjTextureWidth().getText()));
						propertiesPanel.getObjList().setSelectedIndex(propertiesPanel.getObjList().getSelectedIndex());
					}
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
				if ((item >= '0' && item <= '9')|| (item == '.') || (item == '-'))
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
				if ((item >= '0' && item <= '9')|| (item == '.'))
				{
					newCharArray[j] = item;
					j++;
				}
			}
			
			jtf.setText(newCharArray.join(''));
		}
		
		public function comboBoxReload():void {
			propertiesPanel.getPtList().setSelectedIndex(0);
			cleanFields();
			comboBoxContentsPoint(propertiesPanel.getPtList(), aControl.getCtrPoint().getListOfPoints());
			comboBoxContentsObj(propertiesPanel.getObjList(), new Vector.<Object3D>);
		}
		
		public function comboBoxContentsPoint(comboBox:JComboBox, objects:Vector.<Point>):void {
			var obj:Vector.<String> = new Vector.<String>();
			obj.push("New");
			for (var i:int = 1; i <= objects.length; i++ ) {
				obj.push(i);
			}
			comboBox.setListData(copyVectToArray(obj));
		}
		
		public function comboBoxContentsObj(comboBox:JComboBox, objects:Vector.<Object3D>):void {
			var obj:Vector.<String> = new Vector.<String>();
			obj.push("New");
			for (var i:int = 1; i <= objects.length; i++ ) {
				obj.push(i);
			}
			comboBox.setListData(copyVectToArray(obj));
		}
		
		private function copyVectToArray(vet:Vector.<String>):Array	{
			var a:Array = new Array()
			for each(var p:String in vet) {
				a.push(p);
			}
			return a;
		}
		
		public function audioLoad(e:Event):void {
			if (object3dpanel.getObjFile().getText() != "" || videopanel.getObjVideo().getText() != "" || texturepanel.getObjTexture().getText() != "") {
				FileCopy.audioCopy(aControl.getObjCtrUserProject().getCurrentProjectTempFolder(), this);
			}else {
				JOptionPane.showMessageDialog("Warning", "To add a audio file you should first add an object3D, Video or Texture File",null,propertiesPanel);
			}
		}
		
		public function fileLoad(e:Event):void {
			if (propertiesPanel.getPtList().getSelectedItem() == "New") {
				var tempindex:int = propertiesPanel.getPtList().getItemCount();
				aControl.getCtrPoint().addPoint(new Number3D(new Number(propertiesPanel.getPtX().getText()), new Number(propertiesPanel.getPtY().getText()),
				new Number(propertiesPanel.getPtZ().getText())));
				comboBoxContentsPoint(propertiesPanel.getPtList(), aControl.getCtrPoint().getListOfPoints());
				propertiesPanel.getPtList().setSelectedIndex(tempindex);
			}
			FileCopy.colladaCopy(aControl.getObjCtrUserProject().getCurrentProjectTempFolder(), this);
		}
		
		public function videoLoad(e:Event):void {
			if (propertiesPanel.getPtList().getSelectedItem() == "New") {
				var tempindex:int = propertiesPanel.getPtList().getItemCount();
				aControl.getCtrPoint().addPoint(new Number3D(new Number(propertiesPanel.getPtX().getText()), new Number(propertiesPanel.getPtY().getText()),
				new Number(propertiesPanel.getPtZ().getText())));
				comboBoxContentsPoint(propertiesPanel.getPtList(), aControl.getCtrPoint().getListOfPoints());
				propertiesPanel.getPtList().setSelectedIndex(tempindex);
			}
			FileCopy.videoCopy(aControl.getObjCtrUserProject().getCurrentProjectTempFolder(), this);
		}
		
		public function textureLoad(e:Event):void {
			if (propertiesPanel.getPtList().getSelectedItem() == "New") {
				var tempindex:int = propertiesPanel.getPtList().getItemCount();
				aControl.getCtrPoint().addPoint(new Number3D(new Number(propertiesPanel.getPtX().getText()), new Number(propertiesPanel.getPtY().getText()),
				new Number(propertiesPanel.getPtZ().getText())));
				comboBoxContentsPoint(propertiesPanel.getPtList(), aControl.getCtrPoint().getListOfPoints());
				propertiesPanel.getPtList().setSelectedIndex(tempindex);
			}
			FileCopy.textureCopy(aControl.getObjCtrUserProject().getCurrentProjectTempFolder(), this);
		}
		
		public function setPropertiesPanel(propertiesPanel:PropertiesPanel):void {
			this.propertiesPanel = propertiesPanel;
		}
		
		public function setObject3Dpanel(p3dpanel:Object3DPopupPanel):void {
			this.object3dpanel = p3dpanel;
		}
		
		public function setObjectVideoPanel(pVideoPanel:ObjectVideoPopupPanel):void {
			this.videopanel = pVideoPanel;
		}
		
		public function setObjectTexturePanel(pTexturePanel:ObjectTexturePopupPanel):void {
			this.texturepanel = pTexturePanel;
		}
		
		public function setAnimationPanel(pAnimationPanel:AnimationPanel):void
		{
			this._animationPanel = pAnimationPanel;
		}
		
		public function removePoint(e:Event):void {
			JOptionPane.showMessageDialog("Confirmation", "Are you sure about erasing this point?", null, propertiesPanel, true, null, 12).getYesButton().addActionListener(remPt);
		}
		
		private function remPt(e:Event):void {
			aControl.getObjCtrUserProject().setUnsavedModifications(true);
			
			aControl.getCtrPoint().removePoint(propertiesPanel.getPtList().getSelectedIndex() - 1);
			comboBoxContentsPoint(propertiesPanel.getPtList(), aControl.getCtrPoint().getListOfPoints());
			propertiesPanel.getPtList().setSelectedIndex(0);
		}
		
		public function removeObject(e:Event):void {
			JOptionPane.showMessageDialog("Confirmation", "Are you sure about erasing this scene?", null, propertiesPanel, true, null, 12).getYesButton().addActionListener(remObj);
		}
		
		private function remObj(e:Event):void {
			aControl.getObjCtrUserProject().setUnsavedModifications(true);
			
			aControl.getCtrPoint().getCtrListOfObjects(propertiesPanel.getPtList().getSelectedIndex() - 1).removeObject(propertiesPanel.getObjList().getSelectedIndex() - 1);
			
			comboBoxContentsObj(propertiesPanel.getObjList(), aControl.getCtrPoint().getListOfPoints()[propertiesPanel.getPtList().getSelectedIndex() - 1].getListOfObjects());
			propertiesPanel.getObjList().setSelectedIndex(0);
			
		}
		
		public function swapObject(e:Event):void 
		{
			var sw:SwapWindow = new SwapWindow(swapFunction);
			var numberOfScenes:uint;
			var currentScenePos:uint;
			
			//-1 for not couting the New string
			numberOfScenes = propertiesPanel.getObjList().getItemCount() - 1;
			currentScenePos = propertiesPanel.getObjList().getSelectedIndex();
			
			sw.openSwapWindow(numberOfScenes, currentScenePos);
		}
		
		private function swapFunction(pos2Swap:uint):void 
		{	
			aControl.getObjCtrUserProject().setUnsavedModifications(true);
			
			aControl.getCtrPoint().getCtrListOfObjects(propertiesPanel.getPtList().getSelectedIndex() - 1).
					swapObjectPositionTo(propertiesPanel.getObjList().getSelectedIndex() - 1, pos2Swap - 1)
			
			comboBoxContentsObj(propertiesPanel.getObjList(), aControl.getCtrPoint().getListOfPoints()[propertiesPanel.getPtList().getSelectedIndex() - 1].getListOfObjects());
			propertiesPanel.getObjList().setSelectedIndex(0);
		}
		
		public function cleanFields():void {
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
		}
		
		public function audioSelected(e:Event):void {
			//if the has audio checkbox was marked
			if (propertiesPanel.getAudioCheck().isSelected()) 
			{
				propertiesPanel.getbtAudioLoad().setEnabled(true);
				propertiesPanel.getAudioFilePath().setEnabled(true);
				propertiesPanel.getAudioRpt().setEnabled(true);
			}
			//if the has audio checkbox was unmarked
			else 
			{
				//if it's a point selected and a scene selected
				if (propertiesPanel.getPtList().getSelectedIndex() != 0 && propertiesPanel.getObjList().getSelectedIndex() != 0) 
				{
					var object3d:FacadeObject3D = new FacadeObject3D(Point(aControl.getCtrPoint().getListOfPoints()[propertiesPanel.getPtList().getSelectedIndex() - 1]).getListOfObjects()[propertiesPanel.getObjList().getSelectedIndex() - 1]);
					if (object3d.hasAudio())
					{
						aControl.getObjCtrUserProject().setUnsavedModifications(true);
						
						aControl.getCtrPoint().getCtrListOfObjects(propertiesPanel.getPtList().getSelectedIndex() - 1).rebuildObject3D(propertiesPanel.getObjList().getSelectedIndex() - 1, 
							object3d.getFilePath(), object3d.getTranslation(), object3d.getRotation(), 
							object3d.getScale(), object3d.hasTexture(), object3d.getTexturePath(), object3d.getTextureWidth(),
							object3d.getTextureHeight(), false, "", false, object3d.hasVideo(), object3d.getVideoPath(),
							object3d.getVideoWidth(), object3d.getVideoHeight(), object3d.getRepeatVideo(), _animationPanel.getHasAnimation(), _animationPanel.getAnimationPeriod(), _animationPanel.getAnimationRotationAxis(), _animationPanel.getAnimationRadius(), _animationPanel.getAnimationDirection());
						
						aControl.getCtrPoint().goToObject(propertiesPanel.getPtList().getSelectedIndex() - 1, propertiesPanel.getObjList().getSelectedIndex() - 1 );
						
					}
					propertiesPanel.getObjList().setSelectedIndex(propertiesPanel.getObjList().getSelectedIndex());
				}
				propertiesPanel.getbtAudioLoad().setEnabled(false);
				propertiesPanel.getAudioFilePath().setEnabled(false);
				propertiesPanel.getAudioRpt().setEnabled(false);
			}
		}
		
		public function object3DSelected(e:Event):void {
			objectSelect();
		}
		
		private function objectSelect():void {
			if (propertiesPanel.remove(videopanel)||propertiesPanel.remove(texturepanel)) {
				propertiesPanel.append(object3dpanel);
				object3dpanel.show();
			}
		}
		
		public function videoSelected(e:Event):void {
			videoSelect();
		}
		
		private function videoSelect():void {
			if (propertiesPanel.remove(object3dpanel)||propertiesPanel.remove(texturepanel)) {
				propertiesPanel.append(videopanel);
				videopanel.show();
			}
		}
		
		public function textureSelected(e:Event):void {
			textureSelect();
		}
		
		private function textureSelect():void {
			if (propertiesPanel.remove(object3dpanel)||propertiesPanel.remove(videopanel)) {
				propertiesPanel.append(texturepanel);
				texturepanel.show();
			}
		}
		
		public function start():void {
			//modificação Raryel
			MessageWindow.setParentComponent(propertiesPanel);
			
			propertiesPanel.getPtList().setSelectedIndex(0);
			propertiesPanel.getObjList().setSelectedIndex(0);
			propertiesPanel.getbtAudioLoad().setEnabled(false);
			propertiesPanel.getAudioFilePath().setEnabled(false);
			propertiesPanel.getAudioRpt().setEnabled(false);
			propertiesPanel.getRd3dObject().setSelected(true);
			propertiesPanel.append(object3dpanel);
			object3dpanel.show();
		}
		
		public function pointSelected(e:Event):void {
			if (e.currentTarget == propertiesPanel.getPtList())
			{
				if (propertiesPanel.getPtList().getSelectedItem() == null) { } 
				else 
				{
					if (propertiesPanel.getPtList().getSelectedItem() == "New") {
						
						aControl.getCtrPoint().disableAllPointsUI(false);
						propertiesPanel.getPtX().setText("0");
						propertiesPanel.getPtY().setText("0");
						propertiesPanel.getPtZ().setText("0");
						comboBoxContentsObj(propertiesPanel.getObjList(), new Vector.<Object3D>());
						propertiesPanel.getObjList().setSelectedIndex(0);
						
						propertiesPanel.getbtRemovePt().setEnabled(false);
					}
					else 
					{
						propertiesPanel.getbtRemovePt().setEnabled(true);
						
						aControl.getCtrPoint().disableAllPointsUI(false);
						aControl.getCtrPoint().enablePointUI(propertiesPanel.getPtList().getSelectedIndex() - 1);
						
						propertiesPanel.getPtX().setText(aControl.getCtrPoint().getListOfPoints()[propertiesPanel.getPtList().getSelectedIndex()-1].getPosition().x + "");
						propertiesPanel.getPtY().setText(aControl.getCtrPoint().getListOfPoints()[propertiesPanel.getPtList().getSelectedIndex()-1].getPosition().y + "");
						propertiesPanel.getPtZ().setText(aControl.getCtrPoint().getListOfPoints()[propertiesPanel.getPtList().getSelectedIndex()-1].getPosition().z + "");
						comboBoxContentsObj(propertiesPanel.getObjList(), aControl.getCtrPoint().getListOfPoints()[propertiesPanel.getPtList().getSelectedIndex() - 1].getListOfObjects());
						propertiesPanel.getObjList().setSelectedIndex(0);
					}
				}
			}
		}
		
		public function objectSelected(e:Event):void  {
			cleanFields();
			if (e.currentTarget == propertiesPanel.getObjList()) 
			{
				if (propertiesPanel.getPtList().getSelectedItem() == null||propertiesPanel.getObjList().getSelectedItem() == null) { }
				else
				{
					if (String(propertiesPanel.getObjList().getSelectedItem()) == "New") {
						
						aControl.getCtrPoint().disableAllPoints(false);
						propertiesPanel.getObjTrX().setText("0");
						propertiesPanel.getObjTrY().setText("0");
						propertiesPanel.getObjTrZ().setText("0");
						propertiesPanel.getObjRtX().setText("0");
						propertiesPanel.getObjRtY().setText("0");
						propertiesPanel.getObjRtZ().setText("0");
						propertiesPanel.getObjScX().setText("1");
						propertiesPanel.getObjScY().setText("1");
						propertiesPanel.getObjScZ().setText("1");
						
						propertiesPanel.getbtRemoveObj().setEnabled(false);
						propertiesPanel.getbtSwapObj().setEnabled(false);
					}
					else
					{
						propertiesPanel.getbtRemoveObj().setEnabled(true);
						propertiesPanel.getbtSwapObj().setEnabled(true);						
						
						aControl.getCtrPoint().disableAllPoints(false);
						var facade3d:FacadeObject3D = new FacadeObject3D(Point(aControl.getCtrPoint().getListOfPoints()[propertiesPanel.getPtList().getSelectedIndex() - 1]).getListOfObjects()[propertiesPanel.getObjList().getSelectedIndex() - 1]);
						aControl.getCtrPoint().goToObject(propertiesPanel.getPtList().getSelectedIndex() - 1, propertiesPanel.getObjList().getSelectedIndex() - 1 );
						propertiesPanel.getObjTrX().setText(facade3d.getTranslation().x+"");
						propertiesPanel.getObjTrY().setText(facade3d.getTranslation().y+"");
						propertiesPanel.getObjTrZ().setText(facade3d.getTranslation().z+"");
						propertiesPanel.getObjRtX().setText(facade3d.getRotation().x+"");
						propertiesPanel.getObjRtY().setText(facade3d.getRotation().y+"");
						propertiesPanel.getObjRtZ().setText(facade3d.getRotation().z+"");
						propertiesPanel.getObjScX().setText(Math.abs(facade3d.getScale().x)+"");
						propertiesPanel.getObjScY().setText(facade3d.getScale().y+"");
						propertiesPanel.getObjScZ().setText(facade3d.getScale().z +"");
						
						_animationPanel.setHasAnimation(facade3d.hasAnimation());
						_animationPanel.setAnimationPeriod(facade3d.getAnimationPeriod());
						_animationPanel.setAnimationRotationAxis(facade3d.getAnimationRotationAxis());	
						_animationPanel.setAnimationRadius(facade3d.getAnimationRadius());
						_animationPanel.setAnimationRotationDirection(facade3d.getAnimationRotationDirection());
						
						if (facade3d.hasAudio()) 
						{
							propertiesPanel.getAudioCheck().setSelected(true);
							propertiesPanel.getAudioFilePath().setEnabled(true);
							propertiesPanel.getAudioFilePath().setText(facade3d.getAudioPath());
							propertiesPanel.getAudioRpt().setEnabled(true);
							propertiesPanel.getAudioRpt().setSelected(facade3d.getRepeatAudio());
							propertiesPanel.getbtAudioLoad().setEnabled(true);
						}
						if (facade3d.hasVideo()) 
						{
							propertiesPanel.getRdVideoObject().setSelected(true);
							videoSelect();
							videopanel.getObjVideo().setEnabled(true);
							videopanel.getObjVideo().setText(facade3d.getVideoPath());
							videopanel.getObjVideoHeight().setEnabled(true);
							videopanel.getObjVideoHeight().setText(facade3d.getVideoHeight().toString());
							videopanel.getObjVideoWidth().setEnabled(true);
							videopanel.getObjVideoWidth().setText(facade3d.getVideoWidth().toString());
							videopanel.getObjVideoRpt().setEnabled(true);
							videopanel.getObjVideoRpt().setSelected(facade3d.getRepeatVideo());
							videopanel.getBtnVideoLoad().setEnabled(true);
						}
						else if (facade3d.hasTexture()) 
						{
							propertiesPanel.getRdTextureObject().setSelected(true);
							textureSelect();
							texturepanel.getObjTexture().setEnabled(true);
							texturepanel.getObjTexture().setText(facade3d.getTexturePath());
							texturepanel.getObjTextureHeight().setEnabled(true);
							texturepanel.getObjTextureHeight().setText(facade3d.getTextureHeight().toString());
							texturepanel.getObjTextureWidth().setEnabled(true);
							texturepanel.getObjTextureWidth().setText(facade3d.getTextureWidth().toString());
							texturepanel.getBtnTextureLoad().setEnabled(true);
						}
						else 
						{
							propertiesPanel.getRd3dObject().setSelected(true);
							objectSelect();
							object3dpanel.getObjFile().setEnabled(true);
							object3dpanel.getObjFile().setText(facade3d.getFilePath());
							object3dpanel.getBtnObject3dLoad().setEnabled(true);
						}
					}
				}
			}
		}
		
		public function getListOfPoints():Vector.<Point> {
			return aControl.getCtrPoint().getListOfPoints();
		}
		
		public function setRepeatAudio(e:Event):void {
			var facade3d:FacadeObject3D = new FacadeObject3D(Point(aControl.getCtrPoint().getListOfPoints()[propertiesPanel.getPtList().getSelectedIndex() - 1]).getListOfObjects()[propertiesPanel.getObjList().getSelectedIndex() - 1]);
			if (facade3d.getRepeatAudio()) {
				facade3d.setRepeatAudio(false);
			}else facade3d.setRepeatAudio(true);
			propertiesPanel.getObjList().setSelectedIndex(propertiesPanel.getObjList().getSelectedIndex());
		}
		
		public function setRepeatVideo(e:Event):void {
			var facade3d:FacadeObject3D = new FacadeObject3D(Point(aControl.getCtrPoint().getListOfPoints()[propertiesPanel.getPtList().getSelectedIndex() - 1]).getListOfObjects()[propertiesPanel.getObjList().getSelectedIndex() - 1]);
			if (facade3d.getRepeatVideo()) {
				facade3d.setRepeatVideo(false);
			}else facade3d.setRepeatVideo(true);
			propertiesPanel.getObjList().setSelectedIndex(propertiesPanel.getObjList().getSelectedIndex());
		}
		
		public function animationStateUpdate(newState:Boolean):void
		{
			var facObj3D:FacadeObject3D;
			
			if (propertiesPanel.getPtList().getSelectedIndex() != 0 && propertiesPanel.getObjList().getSelectedIndex() != 0) 
			{
				facObj3D = new FacadeObject3D(Point(aControl.getCtrPoint().getListOfPoints()[propertiesPanel.getPtList().getSelectedIndex() - 1]).getListOfObjects()[propertiesPanel.getObjList().getSelectedIndex() - 1]);
				facObj3D.setHasAnimation(_animationPanel.getHasAnimation());
				
				aControl.getCtrPoint().goToObject(propertiesPanel.getPtList().getSelectedIndex() - 1, propertiesPanel.getObjList().getSelectedIndex() - 1 );
			}			
		}
		
		public function animationAxisUpdate(e:Event):void
		{
			var facObj3D:FacadeObject3D;
			
			if (propertiesPanel.getPtList().getSelectedIndex() != 0 && propertiesPanel.getObjList().getSelectedIndex() != 0) 
			{
				facObj3D = new FacadeObject3D(Point(aControl.getCtrPoint().getListOfPoints()[propertiesPanel.getPtList().getSelectedIndex() - 1]).getListOfObjects()[propertiesPanel.getObjList().getSelectedIndex() - 1]);
				facObj3D.setAnimationRotationAxis(_animationPanel.getAnimationRotationAxis());		
				
				aControl.getCtrPoint().goToObject(propertiesPanel.getPtList().getSelectedIndex() - 1, propertiesPanel.getObjList().getSelectedIndex() - 1 );
			}
		}
		
		public function animationPeriodUpdate(e:Event):void
		{
			var facObj3D:FacadeObject3D;
			
			if (propertiesPanel.getPtList().getSelectedIndex() != 0 && propertiesPanel.getObjList().getSelectedIndex() != 0) 
			{
				facObj3D = new FacadeObject3D(Point(aControl.getCtrPoint().getListOfPoints()[propertiesPanel.getPtList().getSelectedIndex() - 1]).getListOfObjects()[propertiesPanel.getObjList().getSelectedIndex() - 1]);
				facObj3D.setAnimationPeriod(_animationPanel.getAnimationPeriod());
				
				aControl.getCtrPoint().goToObject(propertiesPanel.getPtList().getSelectedIndex() - 1, propertiesPanel.getObjList().getSelectedIndex() - 1 );
			}
		}
		
		public function animationRadiusUpdade(e:Event):void
		{
			var facObj3D:FacadeObject3D;
			
			if (propertiesPanel.getPtList().getSelectedIndex() != 0 && propertiesPanel.getObjList().getSelectedIndex() != 0) 
			{
				facObj3D = new FacadeObject3D(Point(aControl.getCtrPoint().getListOfPoints()[propertiesPanel.getPtList().getSelectedIndex() - 1]).getListOfObjects()[propertiesPanel.getObjList().getSelectedIndex() - 1]);
				facObj3D.setAnimationRadius(_animationPanel.getAnimationRadius());
				
				aControl.getCtrPoint().goToObject(propertiesPanel.getPtList().getSelectedIndex() - 1, propertiesPanel.getObjList().getSelectedIndex() - 1 );
			}
		}
		
		public function animationReverseDirectionUpdate():void
		{
			var facObj3D:FacadeObject3D;			
		
			if (propertiesPanel.getPtList().getSelectedIndex() != 0 && propertiesPanel.getObjList().getSelectedIndex() != 0) 
			{
				facObj3D = new FacadeObject3D(Point(aControl.getCtrPoint().getListOfPoints()[propertiesPanel.getPtList().getSelectedIndex() - 1]).getListOfObjects()[propertiesPanel.getObjList().getSelectedIndex() - 1]);
				
				facObj3D.setAnimationRotationDirection(_animationPanel.getAnimationDirection());
				
				aControl.getCtrPoint().goToObject(propertiesPanel.getPtList().getSelectedIndex() - 1, propertiesPanel.getObjList().getSelectedIndex() - 1 );
			}	
		}		
	}
}