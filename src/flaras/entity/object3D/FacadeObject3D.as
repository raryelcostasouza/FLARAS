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

package flaras.entity.object3D 
{
	import org.papervision3d.core.math.*;
	
	public class FacadeObject3D 
	{
		private var aObject3D:Object3D;
		private var aConcreteObject3D:ConcreteObject3D;
		private var aComponentDecorator:ComponentDecorator;
		private var aTextureDecorator:TextureDecorator;
		private var aAudioDecorator:AudioDecorator;
		private var aVideoDecorator:VideoDecorator;
		
		public function FacadeObject3D(pObject3D:Object3D) 
		{
			aObject3D = pObject3D;
			aConcreteObject3D = getConcreteObject3D(aObject3D);
			aComponentDecorator = getComponentDecorator(aObject3D);
			aTextureDecorator = getTextureDecorator(aObject3D);
			aAudioDecorator = getAudioDecorator(aObject3D);
			aVideoDecorator = getVideoDecorator(aObject3D);		
		}
		
		private function getConcreteObject3D(pObject3D:Object3D):ConcreteObject3D
		{
			var objChecked:Object3D;
			
			objChecked = pObject3D;
			
			while (!(objChecked is ConcreteObject3D))
			{
				objChecked = ComponentDecorator(objChecked).getComponent();
			}			
			
			return ConcreteObject3D(objChecked);
		}
		
		private function getComponentDecorator(pObject3D:Object3D):ComponentDecorator
		{
			if (pObject3D is ComponentDecorator)
			{
				return ComponentDecorator(pObject3D);
			}
			else
			{
				return null;
			}
		}
		
		private function getTextureDecorator(pObject3D:Object3D):TextureDecorator
		{
			var componentObject:Object3D;
			var td:TextureDecorator;
			
			if (pObject3D is ComponentDecorator)
			{
				componentObject = ComponentDecorator(pObject3D).getComponent();
			}
			else
			{
				componentObject = null;
			}
			
			if (pObject3D is TextureDecorator || componentObject is TextureDecorator)
			{
				if (componentObject is TextureDecorator)
				{
					td = TextureDecorator(componentObject);
				}
				else
				{
					td = TextureDecorator(pObject3D);
				}			
				
				return td;				
			}
			else
			{
				return null;
			}	
		}
		
		private function getAudioDecorator(pObject3D:Object3D):AudioDecorator
		{
			if (pObject3D is AudioDecorator)
			{
				return AudioDecorator(pObject3D);
			}
			else
			{
				return null;
			}
		}
		
		private function getVideoDecorator(pObject3D:Object3D):VideoDecorator
		{
			var componentObject:Object3D;
			var vd:VideoDecorator;
			
			//In the case that the object is decorated by both Audio Decorator and Video Decorator, accordingly to 
			//CtrObjects, Video Decorator will be applied first, so that the component of the Audio Decorator is the
			// Video Decorator. So we compare the component of the object to check if it's a Video Decorator.
			
			if (pObject3D is ComponentDecorator)
			{
				componentObject = ComponentDecorator(pObject3D).getComponent();
			}
			else
			{
				componentObject = null;
			}
			
			if (pObject3D is VideoDecorator || componentObject is VideoDecorator)
			{
				if (componentObject is VideoDecorator)
				{
					vd = VideoDecorator(componentObject);
				}
				else
				{
					vd = VideoDecorator(pObject3D);
				}
				
				return vd;
			}
			else
			{
				return null;
			}	
		}	
		
		//basic properties -------------------------------------------------------------------------------
		public function getFilePath():String
		{
			return aConcreteObject3D.getFilePath();
		}
		
		public function setFilePath(pFilePath:String):void
		{
			aConcreteObject3D.setFilePath(pFilePath);
		}
		
		public function getTranslation():Number3D
		{
			return aConcreteObject3D.getTranslation();
		}
		
		public function setTranslation(pTranslation:Number3D):void
		{
			aConcreteObject3D.setTranslation(pTranslation);
		}
		
		public function getRotation():Number3D
		{
			return aConcreteObject3D.getRotation();
		}
		
		public function setRotation(pRotation:Number3D):void
		{
			aConcreteObject3D.setRotation(pRotation);
		}
		
		public function getScale():Number3D
		{
			return aConcreteObject3D.getScale();
		}
		
		public function setScale(pScale:Number3D):void
		{
			aConcreteObject3D.setScale(pScale);
		}
		
		public function toggleMirror():void
		{
			aConcreteObject3D.toggleMirror();
		}
		
		//texture properties ----------------------------------------------------------------------------
		public function hasTexture():Boolean
		{
			if (aTextureDecorator)
			{
				return true;
			}
			else
			{
				return false;
			}		
		}
		
		public function getTexturePath():String
		{
			if (aTextureDecorator)
			{
				return aTextureDecorator.getTexturePath();
			}
			else
			{
				return "";
			}
		}
		
		public function setTexturePath(pTexturePath:String):void
		{
			if (aTextureDecorator)
			{
				aTextureDecorator.setTexturePath(pTexturePath);
			}
		}
		
		public function getTextureWidth():Number
		{
			if (aTextureDecorator)
			{
				return aTextureDecorator.getWidth();
			}
			else
			{
				return 0;
			}
		}
		
		public function setTextureWidth(pWidth:Number):void
		{
			if (aTextureDecorator)
			{
				aTextureDecorator.setWidth(pWidth);
			}
		}
		
		public function getTextureHeight():Number
		{
			if (aTextureDecorator)
			{
				return aTextureDecorator.getHeight();
			}
			else
			{
				return 0;
			}
		}
		
		public function setTextureHeight(pHeight:Number):void
		{
			if (aTextureDecorator)
			{
				aTextureDecorator.setHeight(pHeight);
			}
		}
		
		//audio properties -----------------------------------------------------------------------------------
		public function hasAudio():Boolean
		{
			if (aAudioDecorator)
			{
				return true;
			}
			else
			{
				return false;
			}
		}
		
		public function getAudioPath():String
		{
			if (aAudioDecorator)
			{
				return aAudioDecorator.getAudioPath();
			}
			else
			{
				return "";
			}
		}
		
		public function setAudioPath(pAudioPath:String):void
		{
			if (aAudioDecorator)
			{
				aAudioDecorator.setAudioPath(pAudioPath);
			}
		}
		
		public function getRepeatAudio():Boolean
		{
			if (aAudioDecorator)
			{
				return aAudioDecorator.getRepeatAudio();
			}
			else
			{
				return false;
			}
		}	
		
		public function setRepeatAudio(pRepeatAudio:Boolean):void
		{
			if (aAudioDecorator)
			{
				aAudioDecorator.setRepeatAudio(pRepeatAudio);
			}
		}
		
		//video properties ------------------------------------------------------------------------------------
		public function hasVideo():Boolean
		{
			if (aVideoDecorator)
			{
				return true;
			}
			else
			{
				return false;
			}
		}
		
		public function getVideoPath():String
		{
			if (aVideoDecorator)
			{
				return aVideoDecorator.getVideoPath();
			}
			else
			{
				return "";
			}
		}
		
		public function setVideoPath(pVideoPath:String):void
		{
			if (aVideoDecorator)
			{
				aVideoDecorator.setVideoPath(pVideoPath);
			}
		}
		
		public function getVideoWidth():Number
		{
			if (aVideoDecorator)
			{
				return aVideoDecorator.getWidth();
			}
			else
			{
				return 0;
			}
		}
		
		public function setVideoWidth(pWidth:Number):void
		{
			if (aVideoDecorator)
			{
				aVideoDecorator.setWidth(pWidth);
			}
		}
		
		
		public function getVideoHeight():Number
		{
			if (aVideoDecorator)
			{
				return aVideoDecorator.getHeight();
			}
			else
			{
				return 0;
			}
		}
		
		public function setVideoHeight(pHeight:Number):void
		{
			if (aVideoDecorator)
			{
				aVideoDecorator.setHeight(pHeight);
			}
		}
		
		public function getRepeatVideo():Boolean
		{
			if (aVideoDecorator)
			{
				return aVideoDecorator.getRepeatVideo();
			}
			else
			{
				return false;
			}
		}
		
		public function setRepeatVideo(pRepeatVideo:Boolean):void
		{
			if (aVideoDecorator)
			{
				aVideoDecorator.setRepeatVideo(pRepeatVideo);
			}
		}
		
		//animation properties ------------------------------------------------------------------------------------
		public function hasAnimation():Boolean
		{
			return aConcreteObject3D.getAnimation().getHasAnimation();
		}
		
		public function getAnimationPeriod():Number
		{
			return aConcreteObject3D.getAnimation().getPeriod();
		}
		
		public function getAnimationRotationAxis():uint
		{
			return aConcreteObject3D.getAnimation().getRotationAxis();
		}
		
		public function setHasAnimation(hasAnimation:Boolean):void
		{
			aConcreteObject3D.getAnimation().setHasAnimation(hasAnimation);
		}
		
		public function setAnimationPeriod(animationPeriod:Number):void
		{
			aConcreteObject3D.getAnimation().setPeriod(animationPeriod);
		}
		
		public function setAnimationRotationAxis(rotationAxis:uint):void
		{
			aConcreteObject3D.getAnimation().setRotationAxis(rotationAxis);
		}		
				
		//other methods
		public function updateObject3DPosition():void
		{
			if (aComponentDecorator)
			{
				aComponentDecorator.updateObject3DPosition();
			}
			else
			{
				aConcreteObject3D.updateObject3DPosition();
			}
		}
		
		public function unLoad():void
		{
			if (aComponentDecorator)
			{
				aComponentDecorator.unLoad();
			}
			else
			{
				aConcreteObject3D.unLoad();
			}
		}
		
		public function unLoadAndRemoveFile(removeAudio:Boolean):void
		{
			if (aComponentDecorator)
			{
				aComponentDecorator.unLoadAndRemoveFile(removeAudio);
			}
			else
			{
				aConcreteObject3D.unLoadAndRemoveFile(removeAudio);
			}
		}
		
		public function removeAudioFile():void
		{
			if (aAudioDecorator)
			{
				aAudioDecorator.removeAudioFile();
			}
		}
	}
}