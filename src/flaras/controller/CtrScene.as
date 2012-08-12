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
		
		public function addScene(pFilePath:String, pTranslation:Number3D, pRotation:Number3D, 
										pScale:Number3D, pHasTexture:Boolean, pTexturePath:String, pTextureWidth:Number, pTextureHeight:Number, 
										pHasAudio:Boolean, pAudioPath:String, pRepeatAudio:Boolean, pHasVideo:Boolean, pVideoPath:String,
										pVideoWidth:Number, pVideoHeight:Number, pRepeatVideo:Boolean,
										pHasAnimation:Boolean, pAnimationPeriod:Number, pAnimationRotationAxis:uint,
										pAnimationRadius:uint, pAnimationRotationDirection:int):void
		{
			var scene:FlarasScene;
			
			_ctrMain.ctrUserProject.setUnsavedModifications(true);
			
			scene = buildScene(pFilePath, pTranslation, pRotation,
									absScale(pScale), pHasTexture, pTexturePath, pTextureWidth, pTextureHeight, 
									pHasAudio, pAudioPath, pRepeatAudio, 
									pHasVideo, pVideoPath, pVideoWidth, pVideoHeight, pRepeatVideo,
									pHasAnimation, pAnimationPeriod, pAnimationRotationAxis, pAnimationRadius, pAnimationRotationDirection);
			
			_listOfScenes2.push(scene);
			_listOfViewFlarasScenes.push(buildViewScene(scene));
		}
		
		private static function absScale(scale:Number3D):Number3D
		{
			return new Number3D(Math.abs(scale.x), Math.abs(scale.y), Math.abs(scale.z));
		}
		
		private function buildScene(pFilePath:String, pTranslation:Number3D, pRotation:Number3D, 
										pScale:Number3D, pHasTexture:Boolean, pTexturePath:String, pTextureWidth:Number, pTextureHeight:Number, 
										pHasAudio:Boolean, pAudioPath:String, pRepeatAudio:Boolean, pHasVideo:Boolean, pVideoPath:String,
										pVideoWidth:Number, pVideoHeight:Number, pRepeatVideo:Boolean,
										pHasAnimation:Boolean, pAnimationPeriod:Number, pAnimationRotationAxis:uint,
										pAnimationRadius:uint, pAnimationRotationDirection:int):FlarasScene
		{
			var flarasScene:FlarasScene;
			
			if (pHasVideo)
			{
				flarasScene = new VideoScene(_point, pTranslation, pRotation, absScale(pScale), pVideoPath, pRepeatVideo, pVideoWidth, pVideoHeight);
			}
			else if (pHasTexture)
			{
				flarasScene = new TextureScene(_point, pTranslation, pRotation, absScale(pScale), pTexturePath, pTextureWidth, pTextureHeight);
			}	
			else
			{
				flarasScene = new VirtualObjectScene(_point, pTranslation, pRotation, absScale(pScale), pFilePath);
			}	
			
			if (pHasAudio)
			{
				flarasScene.setAudio(new AudioScene(flarasScene, pAudioPath, pRepeatAudio));
			}
			
			if (pHasAnimation)
			{
				flarasScene.setAnimation(new AnimationScene(pAnimationPeriod, pAnimationRotationAxis, pAnimationRadius, pAnimationRotationDirection));
			}
			
			return flarasScene;
		}
		
		public function updateRebuildScene(indexScene:uint, pFilePath:String, pTranslation:Number3D, pRotation:Number3D, 
										pScale:Number3D, pHasTexture:Boolean, pTexturePath:String, pTextureWidth:Number, pTextureHeight:Number, 
										pHasAudio:Boolean, pAudioPath:String, pRepeatAudio:Boolean, pHasVideo:Boolean, pVideoPath:String,
										pVideoWidth:Number, pVideoHeight:Number, pRepeatVideo:Boolean,
										pHasAnimation:Boolean, pAnimationPeriod:Number, pAnimationRotationAxis:uint,
										pAnimationRadius:uint, pAnimationRotationDirection:int):void
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
				scene = buildScene(pFilePath, pTranslation, pRotation,
									absScale(pScale), pHasTexture, pTexturePath, pTextureWidth, pTextureHeight, 
									pHasAudio, pAudioPath, pRepeatAudio, 
									pHasVideo, pVideoPath, pVideoWidth, pVideoHeight, pRepeatVideo,
									pHasAnimation, pAnimationPeriod, pAnimationRotationAxis, pAnimationRadius, pAnimationRotationDirection);
				viewFlarasScene = buildViewScene(scene);
				
				//updating scene lists
				_listOfScenes2[indexScene] =scene;
				_listOfViewFlarasScenes[indexScene] = viewFlarasScene;				
			}	
			
			viewFlarasScene.showScene(true);			
		}
		
		private function buildViewScene(scene:FlarasScene):ViewFlarasScene
		{
			var viewFlarasScene:ViewFlarasScene;
			
			if (scene is VirtualObjectScene)
			{
				viewFlarasScene = new ViewVirtualObjectScene(VirtualObjectScene(scene));
			}
			else if (scene is TextureScene)
			{
				viewFlarasScene = new ViewTextureScene(TextureScene(scene));
			}
			else
			{
				viewFlarasScene = new ViewVideoScene(VideoScene(scene));
			}
			
			if (scene.getAudio())
			{
				viewFlarasScene.setViewAudio(new ViewAudioScene(scene.getAudio()));
			}
			
			if (scene.getAnimation())
			{
				viewFlarasScene.setViewAnimation(new ViewAnimationScene(scene.getAnimation(), viewFlarasScene));
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
			viewScene.reloadPointPosition();			
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
				viewScene.unLoad();
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
			}
		}
		
		public function updateAddAnimation(indexScene:uint, period:Number, rotationAxis:uint, radius:uint, rotationDirection:int):void
		{
			var viewScene:ViewFlarasScene;
			var scene:FlarasScene;
			var animationScene:AnimationScene;
			var viewAnimationScene:ViewAnimationScene;
			
			_ctrMain.ctrUserProject.setUnsavedModifications(true);
			
			scene = getScene(indexScene);
			viewScene = getViewScene(indexScene);
			
			animationScene = new AnimationScene(period, rotationAxis, radius, rotationDirection);
			scene.setAnimation(animationScene);
			
			viewAnimationScene = new ViewAnimationScene(animationScene, viewScene);			
			viewScene.setViewAnimation(viewAnimationScene);	
			
			viewScene.showScene(true);
		}
		
		public function updateAnimationProperties(indexScene:uint, period:Number, rotationAxis:uint, radius:uint, rotationDirection:int):void
		{
			var scene:FlarasScene;
			var viewScene:ViewFlarasScene;
			
			_ctrMain.ctrUserProject.setUnsavedModifications(true);
			
			scene = getScene(indexScene);
			viewScene = getViewScene(indexScene);
			
			if (scene.getAnimation())
			{
				viewScene.getViewAnimation().unLoad();
				scene.getAnimation().setAnimationProperties(period, rotationAxis, radius, rotationDirection);
			}	
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
				viewScene.getViewAnimation().unLoad();
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
	}
}