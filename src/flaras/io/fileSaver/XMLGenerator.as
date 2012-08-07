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

package flaras.io.fileSaver 
{
	import flaras.entity.*;
	import flaras.model.*;
	import flaras.model.marker.*;
	import flaras.model.point.*;
	import org.papervision3d.core.math.*;
	
	public class XMLGenerator
	{
		public static function generateXMLInteractionSphere(modelInteractionMarker:ModelInteractionMarker):XML
		{
			var xml:XML = new XML("<data></data>");
			
			var infoNode:XML = new XML();
			infoNode = 
				<info>
					<distanceToMarker>{modelInteractionMarker.getSphereDistance()}</distanceToMarker>
					<size>{modelInteractionMarker.getSphereSize()}</size>
				</info>
			xml.appendChild(infoNode);
			
			return xml;
		}
		
		public static function generateXMLPoints(pListOfPoints:Vector.<Point>):XML
		{
			var xml:XML = new XML("<pointsList></pointsList>");
		
			for each(var p:Point in pListOfPoints)
			{
				var position:Number3D = p.getPosition();
				
				var newNode:XML = new XML();
				newNode = 
				<point>
					<position>
						<x>{position.x}</x>
						<y>{position.y}</y>
						<z>{position.z}</z>
					</position>
				<filePathObjectList>{p.getFilePathListOfObjects()}</filePathObjectList>					
				</point>;
				
				xml = xml.appendChild(newNode);
			}
			return xml;
		}
		
		/*public static function generateXMLObjects(pListOfObjects:Vector.<Object3D>):XML
		{
			var xml:XML = new XML("<objectsList></objectsList>");
			var concreteObject3D:ConcreteObject3D;
			var translation:Number3D;
			var rotation:Number3D;
			var scale:Number3D;
			var objChecked:Object3D;
			
			for each(var obj:Object3D in pListOfObjects)
			{
				var facadeObj3D:FacadeObject3D;
				
				facadeObj3D = new FacadeObject3D(obj);
				
				translation = facadeObj3D.getTranslation();
				rotation = facadeObj3D.getRotation();
				scale = facadeObj3D.getScale();
				
				var newNode:XML = new XML();
				newNode = 
				<object3D>
					<filePath>{facadeObj3D.getFilePath()}</filePath>
					<translation>
						<x>{translation.x}</x>
						<y>{translation.y}</y>
						<z>{translation.z}</z>
					</translation>
					<rotation>
						<x>{rotation.x}</x>
						<y>{rotation.y}</y>
						<z>{rotation.z}</z>
					</rotation>
					<scale>
						<x>{Math.abs(scale.x)}</x>
						<y>{scale.y}</y>
						<z>{scale.z}</z>
					</scale>
					{XMLGenerator.generateXMLTexture(facadeObj3D)}
					{XMLGenerator.generateXMLAudio(facadeObj3D)}
					{XMLGenerator.generateXMLVideo(facadeObj3D)}
					{XMLGenerator.generateXMLAnimation(facadeObj3D)}
				</object3D>;
				
				xml = xml.appendChild(newNode);
			}
			return xml;
		}*/
		
		public static function generateXMLObjects(pListOfObjects:Vector.<FlarasScene>):XML
		{
			var xml:XML = new XML("<objectsList></objectsList>");
			var translation:Number3D;
			var rotation:Number3D;
			var scale:Number3D;
			var pathObj3D:String;
			
			for each(var scene:FlarasScene in pListOfObjects)
			{
				translation = scene.getTranslation();
				rotation = scene.getRotation();
				scale = scene.getScale();
				
				if (scene is VirtualObjectScene)
				{
					pathObj3D = VirtualObjectScene(scene).getPath3DObjectFile();
				}
				else
				{
					pathObj3D = "";
				}
				
				var newNode:XML = new XML();
				newNode = 
				<object3D>
					<filePath>{pathObj3D}</filePath>
					<translation>
						<x>{translation.x}</x>
						<y>{translation.y}</y>
						<z>{translation.z}</z>
					</translation>
					<rotation>
						<x>{rotation.x}</x>
						<y>{rotation.y}</y>
						<z>{rotation.z}</z>
					</rotation>
					<scale>
						<x>{scale.x}</x>
						<y>{scale.y}</y>
						<z>{scale.z}</z>
					</scale>
					{XMLGenerator.generateXMLTexture(scene)}
					{XMLGenerator.generateXMLAudio(scene)}
					{XMLGenerator.generateXMLVideo(scene)}
					{XMLGenerator.generateXMLAnimation(scene)}
				</object3D>;
				
				xml = xml.appendChild(newNode);
			}
			return xml;
		}
		
		/*private static function generateXMLTexture(pFacadeObj3D:FacadeObject3D):XML
		{
			var xml:XML;
			
			xml = new XML();
			
			xml = 
				<texture>
					<hasTexture>{uint(pFacadeObj3D.hasTexture())}</hasTexture>
					<texturePath>{pFacadeObj3D.getTexturePath()}</texturePath>
					<width>{pFacadeObj3D.getTextureWidth()}</width>
					<height>{pFacadeObj3D.getTextureHeight()}</height>
				</texture>;
		
			return xml;			
		}*/
		
		private static function generateXMLTexture(scene:FlarasScene):XML
		{
			var xml:XML;
			var hasTexture:uint;
			var textureScene:TextureScene;
			var texturePath:String;
			var textureWidth:Number;
			var textureHeight:Number;
			
			if (scene is TextureScene)
			{
				textureScene = TextureScene(scene);
				hasTexture = 1;
				texturePath = textureScene.getTextureFilePath();
				textureWidth = textureScene.getWidth();
				textureHeight = textureScene.getHeight();				
			}
			else
			{
				hasTexture = 0;
				texturePath = "";
				textureWidth = 0;
				textureHeight = 0;
			}
			
			xml = new XML();
			
			xml = 
				<texture>
					<hasTexture>{hasTexture}</hasTexture>
					<texturePath>{texturePath}</texturePath>
					<width>{textureWidth}</width>
					<height>{textureHeight}</height>
				</texture>;
		
			return xml;			
		}
		
		/*private static function generateXMLAudio(pFacadeObj3D:FacadeObject3D):XML
		{
			var xml:XML;
			
			xml = new XML();
		
			xml = 
				<audio>
					<hasAudio>{uint(pFacadeObj3D.hasAudio())}</hasAudio>
					<audioPath>{pFacadeObj3D.getAudioPath()}</audioPath>
					<repeatAudio>{uint(pFacadeObj3D.getRepeatAudio())}</repeatAudio>
				</audio>;
	
			return xml;
		}*/
		
		private static function generateXMLAudio(scene:FlarasScene):XML
		{
			var xml:XML;
			var hasAudio:uint;
			var audioScene:AudioScene;
			var audioPath:String;
			var repeat:uint;
			
			if (scene.getAudio())
			{
				audioScene = scene.getAudio();
				hasAudio = 1;
				audioPath = audioScene.getAudioFilePath();
				repeat = uint(audioScene.getRepeatAudio());
			}
			else
			{
				hasAudio = 0;
				audioPath = "";
				repeat = 0;
			}
			
			xml = new XML();
		
			xml = 
				<audio>
					<hasAudio>{hasAudio}</hasAudio>
					<audioPath>{audioPath}</audioPath>
					<repeatAudio>{repeat}</repeatAudio>
				</audio>;
	
			return xml;
		}
		
		/*private static function generateXMLVideo(pFacadeObj3D:FacadeObject3D):XML
		{
			var xml:XML;
			
			xml = new XML();	
			
			xml = 
				<video>
					<hasVideo>{uint(pFacadeObj3D.hasVideo())}</hasVideo>
					<videoPath>{pFacadeObj3D.getVideoPath()}</videoPath>
					<width>{pFacadeObj3D.getVideoWidth()}</width>
					<height>{pFacadeObj3D.getVideoHeight()}</height>
					<repeatVideo>{uint(pFacadeObj3D.getRepeatVideo())}</repeatVideo>
				</video>;
					
			return xml;
		}*/
		
		private static function generateXMLVideo(scene:FlarasScene):XML
		{
			var xml:XML;
			var videoScene:VideoScene;
			var hasVideo:uint;
			var videoPath:String;
			var width:Number;
			var height:Number;
			var repeat:uint;
			
			if (scene is VideoScene)
			{
				videoScene = VideoScene(scene);
				hasVideo = 1;
				videoPath = videoScene.getVideoFilePath();
				width = videoScene.getWidth();
				height = videoScene.getHeight();
				repeat = uint(videoScene.getRepeatVideo());
			}
			else
			{
				hasVideo = 0;
				videoPath = "";
				width = 0;
				height = 0;
				repeat = 0;
			}
			
			xml = new XML();	
			
			xml = 
				<video>
					<hasVideo>{hasVideo}</hasVideo>
					<videoPath>{videoPath}</videoPath>
					<width>{width}</width>
					<height>{height}</height>
					<repeatVideo>{repeat}</repeatVideo>
				</video>;
					
			return xml;
		}
		
		/*private static function generateXMLAnimation(pFacadeObject3D:FacadeObject3D):XML
		{
			var xml:XML;
			
			xml = new XML();	
			
			xml = 
				<animation>
						<hasAnimation>{uint(pFacadeObject3D.hasAnimation())}</hasAnimation>
						<period>{pFacadeObject3D.getAnimationPeriod()}</period>
						<rotationAxis>{pFacadeObject3D.getAnimationRotationAxis()}</rotationAxis>
						<radius>{pFacadeObject3D.getAnimationRadius()}</radius>
						<rotationDirection>{pFacadeObject3D.getAnimationRotationDirection()}</rotationDirection>
					</animation>
					
			return xml;
		}*/
		
		private static function generateXMLAnimation(scene:FlarasScene):XML
		{
			var xml:XML;
			var animationScene:AnimationScene;
			var hasAnimation:uint;
			var period:Number;
			var rotationAxis:uint;
			var radius:uint;
			var rotationDirection:int;
			
			if (scene.getAnimation())
			{
				animationScene = scene.getAnimation();
				hasAnimation = 1;
				period = animationScene.getPeriod();
				rotationAxis = animationScene.getRotationAxis();
				radius = animationScene.getRadius();
				rotationDirection = animationScene.getRotationDirection();
			}
			else
			{
				hasAnimation = 0;
				period = 0;
				rotationAxis = 0;
				radius = 0;
				rotationDirection = 0;
			}
			
			xml = new XML();	
			
			xml = 
				<animation>
						<hasAnimation>{hasAnimation}</hasAnimation>
						<period>{period}</period>
						<rotationAxis>{rotationAxis}</rotationAxis>
						<radius>{radius}</radius>
						<rotationDirection>{rotationDirection}</rotationDirection>
					</animation>
					
			return xml;
		}
	}
}