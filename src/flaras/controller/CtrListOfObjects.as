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
	import flaras.constants.*;
	import flaras.entity.*;
	import flaras.entity.object3D.*;
	import flaras.io.*;
	import flaras.model.*;
	import flaras.view.scene.*;
	import flash.filesystem.*;
	import org.papervision3d.core.math.*;
	
	public class CtrListOfObjects 
	{
		//private var _listOfScenes:Vector.<Object3D>;
		private var _point:Point;
		private var _ctrMain:CtrMain;
		
		private var _listOfScenes2:Vector.<FlarasScene>;
		private var _listOfViewFlarasScenes:Vector.<ViewFlarasScene>;
		
		public function CtrListOfObjects(point:Point)
		{
			this._point = point;
			//this._listOfScenes = _point.getListOfScenes();
			this._listOfScenes2 = _point.getListOfFlarasScenes();
			this._listOfViewFlarasScenes = new Vector.<ViewFlarasScene>();
		}
	
		/*public function addObject(pFilePath:String, pTranslation:Number3D, pRotation:Number3D, 
										pScale:Number3D, pHasTexture:Boolean, pTexturePath:String, pTextureWidth:Number, pTextureHeight:Number, 
										pHasAudio:Boolean, pAudioPath:String, pRepeatAudio:Boolean, pHasVideo:Boolean, pVideoPath:String,
										pVideoWidth:Number, pVideoHeight:Number, pRepeatVideo:Boolean,
										pHasAnimation:Boolean, pAnimationPeriod:Number, pAnimationRotationAxis:uint,
										pAnimationRadius:uint, pAnimationRotationDirection:int):void
		{
			var obj3D:Object3D = buildObject3D(pFilePath, pTranslation, pRotation,
									pScale, pHasTexture, pTexturePath, pTextureWidth, pTextureHeight, 
									pHasAudio, pAudioPath, pRepeatAudio, 
									pHasVideo, pVideoPath, pVideoWidth, pVideoHeight, pRepeatVideo,
									pHasAnimation, pAnimationPeriod, pAnimationRotationAxis, pAnimationRadius, pAnimationRotationDirection);

			_listOfScenes.push(obj3D);
		}*/
		
		//function used to rebuild a new object 3D with the right decorators 
		//for example if the object is initially a texture, and the user want to change it to a video
		/*public function rebuildObject3D(pObjectIndex:uint, pFilePath:String, pTranslation:Number3D, pRotation:Number3D, 
										pScale:Number3D, pHasTexture:Boolean, pTexturePath:String, pTextureWidth:Number, pTextureHeight:Number, 
										pHasAudio:Boolean, pAudioPath:String, pRepeatAudio:Boolean, pHasVideo:Boolean, pVideoPath:String,
										pVideoWidth:Number, pVideoHeight:Number, pRepeatVideo:Boolean,
										pHasAnimation:Boolean, pAnimationPeriod:Number, pAnimationRotationAxis:uint, pAnimationRadius:uint,
										pAnimationRotationDirection:int):void
		{
			var obj3DBefore:Object3D;
			var obj3DNew:Object3D;
			var fullRebuildNeeded:Boolean = false;
							
			obj3DBefore = _listOfScenes[pObjectIndex];
			var facObj3DBefore:FacadeObject3D = new FacadeObject3D(obj3DBefore);
			
			// if there has been no changes (add or remove changes only) regarding audio files
			if ((!facObj3DBefore.hasAudio() && !pHasAudio) || (facObj3DBefore.hasAudio() && pHasAudio))
			{
				trace("no Add or Remove AudioChange");
				
				//if just changed the texture file path
				if (facObj3DBefore.hasTexture() && pHasTexture && facObj3DBefore.getTexturePath() != pTexturePath)
				{
					trace("TextureUpdate")
					facObj3DBefore.setTexturePath(pTexturePath);
				}
				//if just changed the video file path
				else if (facObj3DBefore.hasVideo() && pHasVideo && facObj3DBefore.getVideoPath() != pVideoPath)
				{
					trace("videoUpdate")
					facObj3DBefore.setVideoPath(pVideoPath);
				}
				//if just changed the object3d file path
				else if ((!facObj3DBefore.hasVideo() && !pHasVideo) &&
							(!facObj3DBefore.hasTexture() && !pHasTexture) &&
							(facObj3DBefore.getFilePath() != pFilePath))
				{
					trace("object3D update" )
					facObj3DBefore.setFilePath(pFilePath);
				}
				// if just changed the audio file path
				else if (facObj3DBefore.getAudioPath() != pAudioPath)
				{
					trace("audio update")
					facObj3DBefore.setAudioPath(pAudioPath);
				}
				/*
				 * a critical changed happened:
			     * object type before -> object type after
				 * 1) Object3D -> Texture or
				 * 2) Object3D -> Video or
				 * 3) Texture -> Object3D or
				 * 4) Texture -> Video or
				 * 5) Video -> Object3D or
				 * 6) Video -> Texture
				*/				
				/*else 
				{
					trace("critical change")
					fullRebuildNeeded = true;
					// if the object is associated with an audio file, the audio file must not be deleted
					if (facObj3DBefore.hasAudio())
					{
						trace("critical not remove audio")
						facObj3DBefore.unLoadAndRemoveFile(AudioDecorator.DONT_REMOVE_AUDIO_FILE);
					}
					//if the object is not associated with an audio file, everything can be removed
					else
					{
						trace("critical remove audio")
						// as the object is not associated with any audio file, we can remove everything
						facObj3DBefore.unLoadAndRemoveFile(AudioDecorator.REMOVE_AUDIO_FILE);
					}
				}
			}
			//if audio file was added or removed
			else
			{
				fullRebuildNeeded = true;
				//if it was added an audio file
				if (!facObj3DBefore.hasAudio() && pHasAudio)
				{
					trace("audio added")
					facObj3DBefore.unLoad();
				}
				//if the audio file was removed
				else
				{
					trace("audio removed")
					facObj3DBefore.unLoad();
					facObj3DBefore.removeAudioFile();	
				}
			}
			
			if (fullRebuildNeeded)
			{
				obj3DNew = buildObject3D(pFilePath, pTranslation, pRotation,
									pScale, pHasTexture, pTexturePath, pTextureWidth, pTextureHeight, 
									pHasAudio, pAudioPath, pRepeatAudio, 
									pHasVideo, pVideoPath, pVideoWidth, pVideoHeight, pRepeatVideo,
									pHasAnimation, pAnimationPeriod, pAnimationRotationAxis, pAnimationRadius, pAnimationRotationDirection);
				obj3DBefore.disableObject();
				_listOfScenes[pObjectIndex] = obj3DNew;
			}
		}*/
		
		/*private function buildObject3D(pFilePath:String, pTranslation:Number3D, pRotation:Number3D, 
										pScale:Number3D, pHasTexture:Boolean, pTexturePath:String, pTextureWidth:Number, pTextureHeight:Number, 
										pHasAudio:Boolean, pAudioPath:String, pRepeatAudio:Boolean, pHasVideo:Boolean, pVideoPath:String,
										pVideoWidth:Number, pVideoHeight:Number, pRepeatVideo:Boolean,
										pHasAnimation:Boolean, pAnimationPeriod:Number, pAnimationRotationAxis:uint, pAnimationRadius:uint, pAnimationRotationDirection:int):Object3D
		{
			var obj3D:Object3D;
			var animation:Animation;
			
			animation = new Animation(pHasAnimation, pAnimationPeriod, pAnimationRotationAxis, pAnimationRadius, pAnimationRotationDirection);
			obj3D = new ConcreteObject3D(this._point, pFilePath, pTranslation, pRotation, pScale, animation);
			
			//It's essential to apply Video Decorator or Texture Decorator before Audio Decorator because on them we don't call super statement
			//on the overriden methods because there is no Collada file associated to the point.
			if (pHasVideo && !pHasTexture)
			{
				obj3D = new VideoDecorator(obj3D, pVideoPath, pVideoWidth, pVideoHeight, pRepeatVideo);
			}
			else
			{
				if (!pHasVideo && pHasTexture)
				{
					obj3D = new TextureDecorator(obj3D, pTexturePath, pTextureWidth, pTextureHeight);
				}
			}
			
			if (pHasAudio)
			{
				obj3D = new AudioDecorator(obj3D, pAudioPath, pRepeatAudio);
			}
			
			return obj3D;
		}*/
		
		/*public function removeObject(pIndex:uint):void
		{
			var facObj3D:FacadeObject3D;
			
			facObj3D = new FacadeObject3D(_listOfScenes[pIndex]);
			facObj3D.unLoadAndRemoveFile(AudioDecorator.REMOVE_AUDIO_FILE);
			
			_point.setIndexActiveScene(0);
			_point.setIndexLastActiveScene(0);
			
			//remove from the list of objects 1 element, starting from the pIndex position
			_listOfScenes.splice(pIndex, 1);
		}
		
		public function swapObjectPositionTo(indexObjSource:uint, indexObjDestination:uint):void
		{
			var sourceObject:Object3D;
			
			sourceObject = _listOfScenes[indexObjSource];
			sourceObject.disableObject();
			
			//remove the source object from the list
			_listOfScenes.splice(indexObjSource, 1);
			//adds the source element on the destination position
			_listOfScenes.splice(indexObjDestination, 0, sourceObject);
		}*/
		
		/*public function getListOfObjects():Vector.<Object3D>
		{
			return _listOfScenes;
		}*/
		
		public function getListOfFlarasScenes():Vector.<FlarasScene>
		{
			return _listOfScenes2;
		}
		
		//CtrScene
		public function addScene(pFilePath:String, pTranslation:Number3D, pRotation:Number3D, 
										pScale:Number3D, pHasTexture:Boolean, pTexturePath:String, pTextureWidth:Number, pTextureHeight:Number, 
										pHasAudio:Boolean, pAudioPath:String, pRepeatAudio:Boolean, pHasVideo:Boolean, pVideoPath:String,
										pVideoWidth:Number, pVideoHeight:Number, pRepeatVideo:Boolean,
										pHasAnimation:Boolean, pAnimationPeriod:Number, pAnimationRotationAxis:uint,
										pAnimationRadius:uint, pAnimationRotationDirection:int):void
		{
			var scene:FlarasScene;
			
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
			
			/*if (pHasAnimation)
			{
				animationScene = new AnimationScene(flarasScene, pAnimationPeriod, pAnimationRotationAxis, pAnimationRadius, pAnimationRotationDirection);
				flarasScene.setAnimation(animationScene);
			}
			
			if (pHasAudio)
			{
				audioScene = new AudioScene(flarasScene, pAudioPath, pRepeatAudio);
				flarasScene.setAudio(audioScene);
			}*/
			
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
				
				viewFlarasScene.unLoad();
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
		
		public function unLoadScene(indexScene:uint):void
		{
			var viewFlarasScene:ViewFlarasScene;
			
			viewFlarasScene = getViewScene(indexScene);
			viewFlarasScene.unLoad();
		}		

		public function removeScene(indexScene:uint):void
		{
			var flarasScene:FlarasScene;
			var viewFlarasScene:ViewFlarasScene;
			var listOfFilesAndDirs:Vector.<String>;
			
			flarasScene = getScene(indexScene);
			viewFlarasScene = getViewScene(indexScene);
			
			_listOfScenes2.splice(indexScene, 1);
			_listOfViewFlarasScenes.splice(indexScene, 1);
			
			viewFlarasScene.unLoad();
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
			
			scene = getScene(indexScene);
			viewScene = getViewScene(indexScene);
			
			scene.setRotation(rotation);
			viewScene.setRotation(rotation);
		}
		
		public function updateScale(indexScene:uint, scale:Number3D):void
		{
			var viewScene:ViewFlarasScene;
			var scene:FlarasScene;
			
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
			
			scene = getScene(indexScene);
			viewScene = getViewScene(indexScene);
			
			viewScene.getViewAudio().unLoad();
			scene.getAudio().setRepeatAudio(audioRepeat);
		}
		
		public function updateAddAudio(indexScene:uint, audioPath:String, repeatAudio:Boolean):void
		{
			var viewScene:ViewFlarasScene;
			var scene:FlarasScene;
			var audioScene:AudioScene;
			var viewAudioScene:ViewAudioScene;
			
			viewScene = getViewScene(indexScene);
			scene = getScene(indexScene);
			
			audioScene = new AudioScene(scene, audioPath, repeatAudio);
			scene.setAudio(audioScene);	
			
			viewAudioScene = new ViewAudioScene(audioScene);
			viewScene.setViewAudio(viewAudioScene);
		}
		
		public function updateRemoveAudio(indexScene:uint):void
		{
			var viewScene:ViewFlarasScene;
			var scene:FlarasScene;
			
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
			
			scene = getScene(indexScene);
			viewScene = getViewScene(indexScene);
			
			if (scene is TextureScene)
			{
				TextureScene(scene).setSize(width, height);
				viewScene.unLoad();
			}			
		}	
		
		public function updateVideoSize(indexScene:uint, width:Number, height:Number):void
		{
			var scene:FlarasScene;
			var viewScene:ViewFlarasScene;
			
			scene = getScene(indexScene);
			viewScene = getViewScene(indexScene);
			
			if (scene is VideoScene)
			{
				VideoScene(scene).setSize(width, height);
				viewScene.unLoad();
			}			
		}		
		
		public function updateVideoRepeat(indexScene:uint, videoRepeat:Boolean):void
		{
			var viewScene:ViewFlarasScene;
			var scene:FlarasScene;
			
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
			
			scene = getScene(indexScene);
			viewScene = getViewScene(indexScene);
			
			animationScene = new AnimationScene(period, rotationAxis, radius, rotationDirection);
			scene.setAnimation(animationScene);
			
			viewAnimationScene = new ViewAnimationScene(animationScene, viewScene);			
			viewScene.setViewAnimation(viewAnimationScene);		
		}
		
		public function updateAnimationProperties(indexScene:uint, period:Number, rotationAxis:uint, radius:uint, rotationDirection:int):void
		{
			var scene:FlarasScene;
			var viewScene:ViewFlarasScene;
			
			scene = getScene(indexScene);
			viewScene = getViewScene(indexScene);
			
			if (scene.getAnimation())
			{
				scene.getAnimation().setAnimationProperties(period, rotationAxis, radius, rotationDirection);
				viewScene.getViewAnimation().unLoad();
			}			
		}
		
		public function updateRemoveAnimation(indexScene:uint):void
		{
			var scene:FlarasScene;
			var viewScene:ViewFlarasScene;
			
			scene = getScene(indexScene);
			viewScene = getViewScene(indexScene);
			
			if (scene.getAnimation())
			{
				viewScene.getViewAnimation().unLoad();
				viewScene.setViewAnimation(null);
				scene.setAnimation(null);		
			}
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
		
		/*public function updateVideoSize(indexScene:uint, videoSize:Number2D):void
		{
			
		}
		
		public function updateVideoRepeat(indexScene:uint, videoRepeat:Boolean):void
		{
			
		}
		
		public function updateTextureSize(indexScene:uint, textureSize:Number2D):void
		{
			
		}
		
		public function updateAudioRepeat(indexScene:uint, audioRepeat:Boolean):void
		{
			
		}
		
		public function updateAnimationRotationPeriod(indexScene:uint, rotationPeriod:Number):void
		{
			
		}
		
		public function updateAnimationRotationAxis(indexScene:uint, rotationAxis:uint):void
		{
			
		}
		
		public function updateAnimationRadius(indexScene:uint, radius:uint):void
		{
			
		}
		
		public function updateAnimationRotationDirection(indexScene:uint, rotationDirection:int):void
		{
			
		}	*/
		
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