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
	import flaras.controller.constants.*;
	import flaras.controller.io.*;
	import flaras.model.*;
	import flaras.model.point.*;
	import flaras.model.scene.*;
	import flaras.view.scene.*;
	import flash.filesystem.*;
	import org.papervision3d.core.math.*;
	
	public class CtrScene
	{
		private var _point:Point;
		private var _ctrMain:CtrMain;
		
		private var _listOfScenes2:Vector.<FlarasScene>;
		private var _listOfViewFlarasScenes:Vector.<ViewFlarasScene>;
		
		public function CtrScene(ctrMain:CtrMain, point:Point)
		{
			_ctrMain = ctrMain;
			this._point = point;
			this._listOfScenes2 = _point.getListOfFlarasScenes();
			this._listOfViewFlarasScenes = new Vector.<ViewFlarasScene>();
		}
		
		public function getListOfFlarasScenes():Vector.<FlarasScene>
		{
			return _listOfScenes2;
		}
		
		public function resetAllScenesPosition():void
		{
			for each (var vfs:ViewFlarasScene in _listOfViewFlarasScenes) 
			{
				vfs.resetScenePosition();
			}
		}
		
		public function addScene(pFilePath:String, pTranslation:Number3D, pRotation:Number3D, pScale:Number3D,
			pHasTexture:Boolean, pTexturePath:String, pTextureWidth:Number, pTextureHeight:Number, pHasAudio:Boolean,
			pAudioPath:String, pRepeatAudio:Boolean, pHasVideo:Boolean, pVideoPath:String, pVideoWidth:Number,
			pVideoHeight:Number, pRepeatVideo:Boolean, pHasAnimation:Boolean, pCircularAnimationPeriod:Number,
			pCircularAnimationRotationAxis:uint, pCircularAnimationRadiusA:Number, pCircularAnimationRadiusB:Number, 
			pCircularAnimationRotationDirection:int, pAnimationType:String, pP2PAnimationDisplacement:Number3D, 
			pP2PAnimationTime:Number, pP2PAnimationLoop:Boolean, pLabel:String, pIDNumber:int = -1, pFromXML:Boolean=false):void
		{
			var scene:FlarasScene;
			var idNumber:uint;
			
			if (!pFromXML)
			{
				_ctrMain.ctrUserProject.setUnsavedModifications(true);
				idNumber = generateIDNumber();
			}			
			
			if (pIDNumber == -1)
			{
				idNumber = generateIDNumber();
			}
			else
			{
				idNumber = pIDNumber;
			}
			
			scene = buildScene(pFilePath, pTranslation, pRotation, absScale(pScale), pHasTexture, pTexturePath,
				pTextureWidth, pTextureHeight, pHasAudio, pAudioPath, pRepeatAudio, pHasVideo, pVideoPath,
				pVideoWidth, pVideoHeight, pRepeatVideo, pHasAnimation, pCircularAnimationPeriod, pCircularAnimationRotationAxis,
				pCircularAnimationRadiusA, pCircularAnimationRadiusB, pCircularAnimationRotationDirection,
				pAnimationType, pP2PAnimationDisplacement, pP2PAnimationTime, pP2PAnimationLoop,
				pLabel, idNumber);
			
			_listOfScenes2.push(scene);
			_listOfViewFlarasScenes.push(buildViewScene(scene));
		}
		
		private function generateIDNumber():uint
		{
			var id:uint;
			
			id = 0;
			do
			{
				id++;
				
			}while (!isGeneratedIDUnique(id));
			
			return id;
		}
		
		private function isGeneratedIDUnique(pGeneratedID:uint):Boolean
		{
			for each (var s:FlarasScene in _listOfScenes2)
			{
				if (s.getIDNumber() == pGeneratedID)
				{
					return false;
				}
			}
			return true;
		}
		
		private static function absScale(scale:Number3D):Number3D
		{
			return new Number3D(Math.abs(scale.x), Math.abs(scale.y), Math.abs(scale.z));
		}
		
		private function buildScene(pFilePath:String, pTranslation:Number3D, pRotation:Number3D, pScale:Number3D,
			pHasTexture:Boolean, pTexturePath:String, pTextureWidth:Number, pTextureHeight:Number, pHasAudio:Boolean,
			pAudioPath:String, pRepeatAudio:Boolean, pHasVideo:Boolean, pVideoPath:String, pVideoWidth:Number,
			pVideoHeight:Number, pRepeatVideo:Boolean, pHasAnimation:Boolean, pAnimationPeriod:Number,
			pAnimationRotationAxis:uint, pAnimationRadiusA:Number, pAnimationRadiusB:Number, pAnimationRotationDirection:int, 
			pAnimationType:String, pP2PAnimationDisplacement:Number3D, 
			pP2PAnimationTime:Number, pP2PAnimationLoop:Boolean, pLabel:String, pIDNumber:uint):FlarasScene
		{
			var flarasScene:FlarasScene;
			
			if (pHasVideo)
			{
				flarasScene = new VideoScene(_point, pTranslation, pRotation, absScale(pScale), pVideoPath,
					pRepeatVideo, pVideoWidth, pVideoHeight, pLabel, pIDNumber );
			}
			else if (pHasTexture)
			{
				flarasScene = new TextureScene(_point, pTranslation, pRotation, absScale(pScale), pTexturePath,
					pTextureWidth, pTextureHeight, pLabel, pIDNumber);
			}
			else
			{
				flarasScene = new VirtualObjectScene(_point, pTranslation, pRotation, absScale(pScale),
					pFilePath, pLabel, pIDNumber);
			}
			
			if (pHasAudio)
			{
				flarasScene.setAudio(new AudioScene(flarasScene, pAudioPath, pRepeatAudio));
			}
			
			if (pHasAnimation)
			{
				if (pAnimationType.indexOf(AnimationScene.TYPE_CIRCULAR) != -1)
				{
					flarasScene.setAnimation(new CircularAnimationScene(pAnimationPeriod, pAnimationRotationAxis,
					pAnimationRadiusA, pAnimationRadiusB, pAnimationRotationDirection));
				}
				else
				{
					flarasScene.setAnimation(new P2PAnimationScene(pP2PAnimationDisplacement, 
					pP2PAnimationTime, pP2PAnimationLoop));
				}
				
			}
			
			return flarasScene;
		}
		
		public function updateRebuildScene(indexScene:uint, pFilePath:String, pTranslation:Number3D,
			pRotation:Number3D, pScale:Number3D, pHasTexture:Boolean, pTexturePath:String, pTextureWidth:Number,
			pTextureHeight:Number, pHasAudio:Boolean, pAudioPath:String, pRepeatAudio:Boolean, pHasVideo:Boolean,
			pVideoPath:String, pVideoWidth:Number, pVideoHeight:Number, pRepeatVideo:Boolean, pHasAnimation:Boolean,
			pAnimationPeriod:Number, pAnimationRotationAxis:uint, pAnimationRadiusA:Number, pAnimationRadiusB:Number, pAnimationRotationDirection:int,
			pAnimationType:String, pP2PAnimationDisplacement:Number3D, 
			pP2PAnimationTime:Number, pP2PAnimationLoop:Boolean, pLabel:String):void
		{
			var scene:FlarasScene;
			var viewFlarasScene:ViewFlarasScene;
			var videoScene:VideoScene;
			var virtualObjScene:VirtualObjectScene;
			var textureScene:TextureScene;
			
			_ctrMain.ctrUserProject.setUnsavedModifications(true);
			
			scene = getScene(indexScene);
			viewFlarasScene = getViewScene(indexScene);
			
			if (pHasVideo && scene is VideoScene)
			{
				//videoPath changed
				viewFlarasScene.unLoad();
				videoScene = VideoScene(scene);
				FileRemover.remove(FolderConstants.getFlarasAppCurrentFolder() + "/" + videoScene.getVideoFilePath());
				videoScene.setVideoPath(pVideoPath);
			}
			else if (pHasTexture && scene is TextureScene)
			{
				//texturePath changed
				viewFlarasScene.unLoad();
				textureScene = TextureScene(scene);
				FileRemover.remove(FolderConstants.getFlarasAppCurrentFolder() + "/" + textureScene.getTextureFilePath());
				textureScene.setTexturePath(pTexturePath);
			}
			else if (pFilePath.length != 0 && scene is VirtualObjectScene)
			{
				//3DObjPath changed
				viewFlarasScene.unLoad();
				virtualObjScene = VirtualObjectScene(scene);
				FileRemover.remove(Zipped3DFileImporter.get3DFileExtractedFolder(new File(FolderConstants.getFlarasAppCurrentFolder() + "/" + virtualObjScene.getPath3DObjectFile())).nativePath);
				virtualObjScene.set3DObjPath(pFilePath);
			}
			else
			{
				/*critical change happened:
				   object type before -> object type after
				   1) Object3D -> Texture or
				   2) Object3D -> Video or
				   3) Texture -> Object3D or
				   4) Texture -> Video or
				   5) Video -> Object3D or
				 6) Video -> Texture*/
				
				viewFlarasScene.destroy();
				FileRemover.remove(scene.getBaseSceneFilePath());
				
				//removing the scene from lists
				_listOfScenes2.splice(indexScene, 1);
				_listOfViewFlarasScenes.splice(indexScene, 1);
				
				//building new scene
				scene = buildScene(pFilePath, pTranslation, pRotation, absScale(pScale), pHasTexture,
					pTexturePath, pTextureWidth, pTextureHeight, pHasAudio, pAudioPath, pRepeatAudio,
					pHasVideo, pVideoPath, pVideoWidth, pVideoHeight, pRepeatVideo, pHasAnimation, pAnimationPeriod,
					pAnimationRotationAxis, pAnimationRadiusA, pAnimationRadiusB, pAnimationRotationDirection, 
					pAnimationType, pP2PAnimationDisplacement, pP2PAnimationTime, pP2PAnimationLoop,
					pLabel, scene.getIDNumber());
				viewFlarasScene = buildViewScene(scene);
				
				//updating scene lists
				_listOfScenes2[indexScene] = scene;
				_listOfViewFlarasScenes[indexScene] = viewFlarasScene;
			}
			
			viewFlarasScene.showScene(true);
		}
		
		private function buildViewScene(scene:FlarasScene):ViewFlarasScene
		{
			var viewFlarasScene:ViewFlarasScene;
			var circularScene:CircularAnimationScene;
			var p2pScene:P2PAnimationScene;
			
			if (scene is VirtualObjectScene)
			{
				viewFlarasScene = new ViewVirtualObjectScene(VirtualObjectScene(scene), _ctrMain);
			}
			else if (scene is TextureScene)
			{
				viewFlarasScene = new ViewTextureScene(TextureScene(scene), _ctrMain);
			}
			else
			{
				viewFlarasScene = new ViewVideoScene(VideoScene(scene), _ctrMain);
			}
			
			if (scene.getAudio())
			{
				viewFlarasScene.setViewAudio(new ViewAudioScene(scene.getAudio()));
			}
			
			if (scene.getAnimation())
			{
				if (scene.getAnimation() is CircularAnimationScene)
				{
					circularScene = CircularAnimationScene(scene.getAnimation());
					viewFlarasScene.setViewAnimation(new ViewCircularAnimationScene(circularScene, viewFlarasScene));
				}
				else
				{
					p2pScene = P2PAnimationScene(scene.getAnimation());
					viewFlarasScene.setViewAnimation(new ViewP2PAnimationScene(p2pScene, viewFlarasScene));
				}				
			}
			
			return viewFlarasScene;
		}
		
		public function enableScene(indexScene:uint, playAudio:Boolean):void
		{
			var viewFlarasScene:ViewFlarasScene;
			
			viewFlarasScene = _listOfViewFlarasScenes[indexScene];
			viewFlarasScene.showScene(playAudio);
		}
		
		public function disableScene(indexScene:uint):void
		{
			var viewFlarasScene:ViewFlarasScene;
			
			viewFlarasScene = _listOfViewFlarasScenes[indexScene];
			viewFlarasScene.hideScene();
		}
		
		public function destroyScene(indexScene:uint):void
		{
			var viewFlarasScene:ViewFlarasScene;
			
			viewFlarasScene = getViewScene(indexScene);
			viewFlarasScene.destroy();
		}
		
		public function removeScene(indexScene:uint):void
		{
			var flarasScene:FlarasScene;
			var viewFlarasScene:ViewFlarasScene;
			var listOfFilesAndDirs:Vector.<String>;
			
			_ctrMain.ctrUserProject.setUnsavedModifications(true);
			
			flarasScene = getScene(indexScene);
			viewFlarasScene = getViewScene(indexScene);
			
			_ctrMain.ctrPoint.updateRemoveSceneFromAttractListAfterRemoveScene(_point.getIDNumber(), flarasScene.getIDNumber());		
			
			_listOfScenes2.splice(indexScene, 1);
			_listOfViewFlarasScenes.splice(indexScene, 1);
			
			viewFlarasScene.destroy();
			listOfFilesAndDirs = flarasScene.getListOfFilesAndDirs();
			
			//removing data from disk
			for each (var item:String in listOfFilesAndDirs)
			{
				FileRemover.remove(item);
			}
			
			_point.setIndexActiveScene(0);
			_point.setIndexLastActiveScene(0);
		}
		
		public function swapScenePositionTo(indexSceneSource:uint, indexSceneDestination:uint):void
		{
			var viewFlarasScene:ViewFlarasScene;
			var flarasScene:FlarasScene;
			
			_ctrMain.ctrUserProject.setUnsavedModifications(true);
			
			viewFlarasScene = getViewScene(indexSceneSource);
			flarasScene = getScene(indexSceneSource);
			
			viewFlarasScene.hideScene();
			
			//remove the source object from the list
			_listOfScenes2.splice(indexSceneSource, 1);
			_listOfViewFlarasScenes.splice(indexSceneSource, 1);
			//adds the source element on the destination position
			_listOfScenes2.splice(indexSceneDestination, 0, flarasScene);
			_listOfViewFlarasScenes.splice(indexSceneDestination, 0, viewFlarasScene);
		}
		
		public function cloneScene(pIndexScene:uint):FlarasScene
		{
			var scene2Clone:FlarasScene;
			var clone:FlarasScene;
			var newUniqueName:String;
			var obj3dCompleteFilePath:String;
			var audioScene:AudioScene;
			var animationScene:AnimationScene;
		
			var obj3DScene:VirtualObjectScene;
			var textureScene:TextureScene;
			var videoScene:VideoScene;
			
			var circularAnimationScene:CircularAnimationScene;
			var p2pAnimationScene:P2PAnimationScene;
			
			_ctrMain.ctrUserProject.setUnsavedModifications(true);
			
			scene2Clone = getScene(pIndexScene);
			
			if (scene2Clone is VirtualObjectScene)
			{
				obj3DScene = VirtualObjectScene(scene2Clone);
				clone = new VirtualObjectScene(scene2Clone.getParentPoint(), scene2Clone.getTranslation(), scene2Clone.getRotation(), scene2Clone.getScale(), obj3DScene.getPath3DObjectFile(), scene2Clone.getLabel(), generateIDNumber());
			}
			else if (scene2Clone is TextureScene)
			{
				textureScene = TextureScene(scene2Clone);
				clone = new TextureScene(scene2Clone.getParentPoint(), scene2Clone.getTranslation(), scene2Clone.getRotation(), scene2Clone.getScale(), textureScene.getTextureFilePath(), textureScene.getWidth(), textureScene.getHeight(), scene2Clone.getLabel(), generateIDNumber());
			}
			else
			{
				videoScene = VideoScene(scene2Clone);
				clone = new VideoScene(scene2Clone.getParentPoint(), scene2Clone.getTranslation(), scene2Clone.getRotation(), scene2Clone.getScale(), videoScene.getVideoFilePath(), videoScene.getRepeatVideo(), videoScene.getWidth(), videoScene.getHeight(), scene2Clone.getLabel(), generateIDNumber());
			}
			
			//if this scene has audio
			audioScene = scene2Clone.getAudio();
			if (audioScene)
			{
				clone.setAudio(new AudioScene(scene2Clone, audioScene.getAudioFilePath(), audioScene.getRepeatAudio()));
			}
			
			//if this scene has animation
			animationScene = scene2Clone.getAnimation();
			if (animationScene)
			{
				if (animationScene is CircularAnimationScene)
				{
					circularAnimationScene = CircularAnimationScene(animationScene);
					clone.setAnimation(new CircularAnimationScene(circularAnimationScene.getPeriod(), circularAnimationScene.getRotationAxis(), circularAnimationScene.getRadiusA(), circularAnimationScene.getRadiusB(), circularAnimationScene.getRotationDirection()));
				}
				else
				{
					p2pAnimationScene = P2PAnimationScene(animationScene);
					clone.setAnimation(new P2PAnimationScene(p2pAnimationScene.getDisplacement(), p2pAnimationScene.getTime(), p2pAnimationScene.hasLoop()));
				}				
			}
			
			//copy (with unique name) the file (jpg, png, dae, 3ds, mp3, mp4, flv, etc) associated with the scene
			if (scene2Clone is TextureScene)
			{
				newUniqueName = FileCopy.copyUniqueName(new File(scene2Clone.getBaseSceneFilePath()), false);
				TextureScene(clone).setTexturePath(FolderConstants.TEXTURE_FOLDER + newUniqueName);
			}
			else if (scene2Clone is VideoScene)
			{
				newUniqueName = FileCopy.copyUniqueName(new File(scene2Clone.getBaseSceneFilePath()), false);
				VideoScene(clone).setVideoPath(FolderConstants.VIDEO_FOLDER + newUniqueName);
			}
			else
			{
				obj3dCompleteFilePath = FolderConstants.getFlarasAppCurrentFolder() + "/" + VirtualObjectScene(scene2Clone).getPath3DObjectFile();
				newUniqueName = FileCopy.copyUniqueName(new File(obj3dCompleteFilePath), true);			
				VirtualObjectScene(clone).set3DObjPath(FolderConstants.COLLADA_FOLDER + newUniqueName);
			}
			
			if (audioScene)
			{
				newUniqueName = FileCopy.copyUniqueName(new File(FolderConstants.getFlarasAppCurrentFolder() + "/" + audioScene.getAudioFilePath()), false);
				clone.getAudio().setAudioFilePath(FolderConstants.AUDIO_FOLDER + newUniqueName);
			}
			
			_listOfScenes2.push(clone);
			_listOfViewFlarasScenes.push(buildViewScene(clone));
			
			return clone;
		}
		
		public function updateLabel(pIndexScene:uint, pLabel:String):void
		{
			var scene:FlarasScene;
			
			_ctrMain.ctrUserProject.setUnsavedModifications(true);
			
			scene = _listOfScenes2[pIndexScene];
			scene.setLabel(pLabel);
		}
		
		public function updateTranslation(indexScene:uint, translation:Number3D):void
		{
			var viewScene:ViewFlarasScene;
			var scene:FlarasScene;
			
			_ctrMain.ctrUserProject.setUnsavedModifications(true);
			
			scene = getScene(indexScene);
			viewScene = getViewScene(indexScene);
			
			scene.setTranslation(translation);
			viewScene.setTranslation(translation);
		}
		
		public function updateReloadPointPosition(indexScene:uint):void
		{
			var viewScene:ViewFlarasScene;
			
			viewScene = getViewScene(indexScene);
			viewScene.resetScenePosition();
		}
		
		public function updateRotation(indexScene:uint, rotation:Number3D):void
		{
			var viewScene:ViewFlarasScene;
			var scene:FlarasScene;
			
			_ctrMain.ctrUserProject.setUnsavedModifications(true);
			
			scene = getScene(indexScene);
			viewScene = getViewScene(indexScene);
			
			scene.setRotation(rotation);
			viewScene.setRotation(rotation);
		}
		
		public function updateScale(indexScene:uint, scale:Number3D):void
		{
			var viewScene:ViewFlarasScene;
			var scene:FlarasScene;
			
			_ctrMain.ctrUserProject.setUnsavedModifications(true);
			
			scene = getScene(indexScene);
			viewScene = getViewScene(indexScene);
			
			scene.setScale(absScale(scale));
			viewScene.setScale(absScale(scale));
			
			if (viewScene is ViewVideoScene || viewScene is ViewTextureScene)
			{
				viewScene.setMirrorScaleFactor(CtrMirror.MIRRORED_SCALE_FACTOR);
			}
		}
		
		public function updateAudioRepeat(indexScene:uint, audioRepeat:Boolean):void
		{
			var viewScene:ViewFlarasScene;
			var scene:FlarasScene;
			
			_ctrMain.ctrUserProject.setUnsavedModifications(true);
			
			scene = getScene(indexScene);
			viewScene = getViewScene(indexScene);
			
			viewScene.getViewAudio().unLoad();
			scene.getAudio().setRepeatAudio(audioRepeat);
			
			viewScene.showScene(true);
		}
		
		public function updateAddAudio(indexScene:uint, audioPath:String, repeatAudio:Boolean):void
		{
			var viewScene:ViewFlarasScene;
			var scene:FlarasScene;
			var audioScene:AudioScene;
			var viewAudioScene:ViewAudioScene;
			
			_ctrMain.ctrUserProject.setUnsavedModifications(true);
			
			viewScene = getViewScene(indexScene);
			scene = getScene(indexScene);
			
			viewScene.hideScene();
			
			//if does not have audio
			if (!scene.getAudio())
			{
				audioScene = new AudioScene(scene, audioPath, repeatAudio);
				scene.setAudio(audioScene);
				
				viewAudioScene = new ViewAudioScene(audioScene);
				viewScene.setViewAudio(viewAudioScene);
			}
			else
			{
				FileRemover.remove(FolderConstants.getFlarasAppCurrentFolder() + "/" + scene.getAudio().getAudioFilePath());
				scene.getAudio().setAudioFilePath(audioPath);
			}
			
			viewScene.showScene(true);
		}
		
		public function updateRemoveAudio(indexScene:uint):void
		{
			var viewScene:ViewFlarasScene;
			var scene:FlarasScene;
			
			_ctrMain.ctrUserProject.setUnsavedModifications(true);
			
			viewScene = getViewScene(indexScene);
			scene = getScene(indexScene);
			
			viewScene.getViewAudio().unLoad();
			FileRemover.remove(FolderConstants.getFlarasAppCurrentFolder() + "/" + scene.getAudio().getAudioFilePath());
			viewScene.setViewAudio(null);
			scene.setAudio(null);
		}
		
		public function updateTextureSize(indexScene:uint, width:Number, height:Number):void
		{
			var scene:FlarasScene;
			var viewScene:ViewFlarasScene;
			
			_ctrMain.ctrUserProject.setUnsavedModifications(true);
			
			scene = getScene(indexScene);
			viewScene = getViewScene(indexScene);
			
			if (scene is TextureScene)
			{
				TextureScene(scene).setSize(width, height);
				viewScene.unLoad();
				viewScene.showScene(true);
			}
		}
		
		public function updateVideoSize(indexScene:uint, width:Number, height:Number):void
		{
			var scene:FlarasScene;
			var viewScene:ViewFlarasScene;
			
			_ctrMain.ctrUserProject.setUnsavedModifications(true);
			
			scene = getScene(indexScene);
			viewScene = getViewScene(indexScene);
			
			if (scene is VideoScene)
			{
				VideoScene(scene).setSize(width, height);
				viewScene.unLoad();
				viewScene.showScene(true);
			}
		}
		
		public function updateVideoRepeat(indexScene:uint, videoRepeat:Boolean):void
		{
			var viewScene:ViewFlarasScene;
			var scene:FlarasScene;
			
			_ctrMain.ctrUserProject.setUnsavedModifications(true);
			
			scene = getScene(indexScene);
			viewScene = getViewScene(indexScene);
			
			if (scene is VideoScene)
			{
				VideoScene(scene).setRepeatVideo(videoRepeat);
				viewScene.unLoad();
				viewScene.showScene(true);
			}			
		}
		
		public function updateAddCircularAnimation(indexScene:uint, period:Number, rotationAxis:uint, radiusA:Number,
					radiusB:Number, rotationDirection:int):void
		{
			var viewScene:ViewFlarasScene;
			var scene:FlarasScene;
			var animationScene:CircularAnimationScene;
			var viewAnimationScene:ViewCircularAnimationScene;
			
			_ctrMain.ctrUserProject.setUnsavedModifications(true);
			
			scene = getScene(indexScene);
			viewScene = getViewScene(indexScene);
			
			animationScene = new CircularAnimationScene(period, rotationAxis, radiusA, radiusB, rotationDirection);
			scene.setAnimation(animationScene);
			
			viewAnimationScene = new ViewCircularAnimationScene(animationScene, viewScene);
			viewScene.resetScenePosition();
			viewScene.setViewAnimation(viewAnimationScene);
			
			
			viewScene.showScene(true);
		}
		
		public function updateAddP2PAnimation(indexScene:uint, displacement:Number3D,
												time:Number, hasLoop:Boolean):void
		{
			var viewScene:ViewFlarasScene;
			var scene:FlarasScene;
			var animationScene:P2PAnimationScene;
			var viewAnimationScene:ViewP2PAnimationScene;
			
			_ctrMain.ctrUserProject.setUnsavedModifications(true);
			
			scene = getScene(indexScene);
			viewScene = getViewScene(indexScene);
			
			animationScene = new P2PAnimationScene(displacement, time, hasLoop);
			scene.setAnimation(animationScene);
			
			viewAnimationScene = new ViewP2PAnimationScene(animationScene, viewScene);
			viewScene.resetScenePosition();
			viewScene.setViewAnimation(viewAnimationScene);
			
			viewScene.showScene(true);
		}
		
		public function updateCircularAnimationProperties(indexScene:uint, period:Number, rotationAxis:uint,
			radiusA:Number, radiusB:Number, rotationDirection:int):void
		{
			var scene:FlarasScene;
			var viewScene:ViewFlarasScene;
			
			_ctrMain.ctrUserProject.setUnsavedModifications(true);
			
			scene = getScene(indexScene);
			viewScene = getViewScene(indexScene);
			
			if (scene.getAnimation())
			{
				viewScene.getViewAnimation().unLoad();
				CircularAnimationScene(scene.getAnimation()).setAnimationProperties(period, rotationAxis, radiusA, radiusB, rotationDirection);
			}
			viewScene.resetScenePosition();
			viewScene.showScene(true);
		}
		
		public function updateP2PAnimationProperties(indexScene:uint, displacement:Number3D,
													time:Number, hasLoop:Boolean):void
		{
			var scene:FlarasScene;
			var viewScene:ViewFlarasScene;
			
			_ctrMain.ctrUserProject.setUnsavedModifications(true);
			
			scene = getScene(indexScene);
			viewScene = getViewScene(indexScene);
			
			if (scene.getAnimation())
			{
				viewScene.getViewAnimation().unLoad();
				P2PAnimationScene(scene.getAnimation()).setAnimationProperties(displacement, time, hasLoop);
			}
			viewScene.resetScenePosition();
			viewScene.showScene(true);
		}
		
		public function updateRemoveAnimation(indexScene:uint):void
		{
			var scene:FlarasScene;
			var viewScene:ViewFlarasScene;
			
			_ctrMain.ctrUserProject.setUnsavedModifications(true);
			
			scene = getScene(indexScene);
			viewScene = getViewScene(indexScene);
			
			if (scene.getAnimation())
			{
				viewScene.getViewAnimation().destroy();
				viewScene.setViewAnimation(null);
				scene.setAnimation(null);
			}
			
			viewScene.showScene(true);
		}
		
		public function toggleMirrorScenes():void
		{
			for each (var viewScene:ViewFlarasScene in _listOfViewFlarasScenes)
			{
				if (viewScene is ViewTextureScene || viewScene is ViewVideoScene)
				{
					viewScene.toggleMirror();
				}
			}
		}
		
		public function getIDNumber(pIndexScene:uint):uint
		{
			return _listOfScenes2[pIndexScene].getIDNumber();
		}
		
		public function getSceneIndexFromIDNumber(pIDNumber:uint):int
		{
			var i:uint;
			i = 0;
			for each(var scene:FlarasScene in _listOfScenes2)
			{
				if (scene.getIDNumber() == pIDNumber)
				{
					return i;
				}
				else
				{
					i++;
				}
			}
			return -1;
		}
		
		public function getLabel(pIndexScene:uint):String
		{
			return _listOfScenes2[pIndexScene].getLabel();
		}
		
		public function getTranslation(indexScene:uint):Number3D
		{
			return _listOfScenes2[indexScene].getTranslation();
		}
		
		public function getRotation(indexScene:uint):Number3D
		{
			return _listOfScenes2[indexScene].getRotation();
		}
		
		public function getScale(indexScene:uint):Number3D
		{
			return _listOfScenes2[indexScene].getScale();
		}
		
		public function getAudioData(indexScene:uint):AudioScene
		{
			var flarasScene:FlarasScene;
			
			flarasScene = getScene(indexScene);
			if (flarasScene.getAudio())
			{
				return flarasScene.getAudio();
			}
			
			return null;
		}
		
		public function getVideoData(indexScene:uint):VideoScene
		{
			var flarasScene:FlarasScene;
			
			flarasScene = getScene(indexScene);
			if (flarasScene is VideoScene)
			{
				return VideoScene(flarasScene);
			}
			
			return null;
		}
		
		public function getTextureData(indexScene:uint):TextureScene
		{
			var flarasScene:FlarasScene;
			
			flarasScene = getScene(indexScene);
			if (flarasScene is TextureScene)
			{
				return TextureScene(flarasScene);
			}
			
			return null;
		}
		
		public function getVirtualObjectData(indexScene:uint):VirtualObjectScene
		{
			var flarasScene:FlarasScene;
			
			flarasScene = getScene(indexScene);
			if (flarasScene is VirtualObjectScene)
			{
				return VirtualObjectScene(flarasScene);
			}
			
			return null;
		}
		
		public function getAnimationData(indexScene:uint):AnimationScene
		{
			var flarasScene:FlarasScene;
			
			flarasScene = getScene(indexScene);
			if (flarasScene.getAnimation())
			{
				return flarasScene.getAnimation();
			}
			
			return null;
		}
		
		public function getNumberOfScenes():uint
		{
			return _listOfScenes2.length;
		}
		
		private function getScene(indexScene:uint):FlarasScene
		{
			return _listOfScenes2[indexScene];
		}
		
		private function getViewScene(indexScene:uint):ViewFlarasScene
		{
			return _listOfViewFlarasScenes[indexScene];
		}
		
		public function getSceneIndex(flarasScene:FlarasScene):int
		{
			for (var i:uint = 0; i < _listOfScenes2.length; i++ )
			{
				if (_listOfScenes2[i] == flarasScene)
				{
					return i;
				}
			}
			return -1;
		}
	}
}