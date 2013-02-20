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

package flaras.controller.io.fileSaver 
{
	import flaras.controller.util.Point3D;
	import flaras.model.*;
	import flaras.model.marker.*;
	import flaras.model.point.*;
	import flaras.model.scene.*;
	import flaras.model.util.ModelProjectVersion;
	import org.papervision3d.core.math.*;
	
	public class XMLGenerator
	{
		public static function generateXMLProject(modelProjectVersion:ModelProjectVersion):XML
		{
			var xml:XML = new XML("<project></project>");
			
			var infoNode:XML = new XML();
			infoNode = 
				<version>
					<release>{modelProjectVersion.getRelease()}</release>
					<subRelease>{modelProjectVersion.getSubRelease()}</subRelease>
					<bugFix>{modelProjectVersion.getBugFix()}</bugFix>
				</version>
			xml.appendChild(infoNode);
			return xml;
		}
		
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
		
		public static function generateXMLRefMarker(modelRefMarker:ModelRefMarker):XML 
		{
			var xml:XML = new XML("<refMarkerData></refMarkerData>");
			
			var infoNode:XML = new XML();
			infoNode = 
				<baseType>{modelRefMarker.getBaseType()}</baseType>
			xml.appendChild(infoNode);
			
			return xml;
		}
		
		public static function generateXMLPoints(pListOfPoints:Vector.<Point>):XML
		{
			var xml:XML = new XML("<pointsList></pointsList>");
			var pointAttractionRepulsion:AttractionRepulsionPoint;
		
			for each(var p:Point in pListOfPoints)
			{
				var position:Number3D = p.getPosition();
				var label:String = p.getLabel();
				var moveInteractionForScenes:uint;
				var type:String;
				
				if (p.isMoveInteractionForScenes())
				{
					moveInteractionForScenes = 1;
				}
				else
				{
					moveInteractionForScenes = 0;
				}	
				
				if (p is AttractionRepulsionPoint)
				{
					type = "attraction-repulsion";
				}
				else
				{
					type = "default";
				}
				
				var newNode:XML = new XML();
				newNode = 
				<point>
					<idNumber>{p.getIDNumber()}</idNumber>
					<type>{type}</type>
					<label>{label}</label>
					<moveInteractionForScenes>{moveInteractionForScenes}</moveInteractionForScenes>
					<position>
						<x>{position.x}</x>
						<y>{position.y}</y>
						<z>{position.z}</z>
					</position>
				<filePathObjectList>{p.getFilePathListOfObjects()}</filePathObjectList>
				{XMLGenerator.generateXMLAttractionSphereRadius(p)}
				{XMLGenerator.generateXMLRefScenes2Attract(p) }				
				</point>;
				
				xml = xml.appendChild(newNode);
			}
			return xml;
		}
		
		private static function generateXMLAttractionSphereRadius(p:Point):XML
		{
			var pointAttractionRepulsion:AttractionRepulsionPoint;
			
			if (p is AttractionRepulsionPoint)
			{
				pointAttractionRepulsion = AttractionRepulsionPoint(p);
				return new XML("<attractionSphereRadius>"+pointAttractionRepulsion.getAttractionSphereRadius()+"</attractionSphereRadius>")
			}
			else
			{
				return new XML();
			}		
		}
		
		private static function generateXMLRefScenes2Attract(p:Point):XML
		{
			var xml:XML;
			var newNode:XML;
			var pointAttractionRepulsion:AttractionRepulsionPoint;
			
			xml = new XML("<listOfScenes2Attract></listOfScenes2Attract>");
			if (p is AttractionRepulsionPoint)
			{
				pointAttractionRepulsion = AttractionRepulsionPoint(p);
				for each(var objRef:RefScene2Attract in pointAttractionRepulsion.getListOfScenes2Attract())
				{
					newNode = 
					<refScene2Attract>
						<pointIndex>{objRef.getPointIDNumber()}</pointIndex>
						<sceneIDNumber>{objRef.getSceneIDNumber()}</sceneIDNumber>
					</refScene2Attract>
					
					xml = xml.appendChild(newNode);
				}				
				return xml;
			}
			else
			{
				return new XML();
			}
		}
		
		public static function generateXMLObjects(pListOfObjects:Vector.<FlarasScene>):XML
		{
			var xml:XML = new XML("<objectsList></objectsList>");
			var translation:Number3D;
			var rotation:Number3D;
			var scale:Number3D;
			var pathObj3D:String;
			var label:String;
			
			for each(var scene:FlarasScene in pListOfObjects)
			{
				translation = scene.getTranslation();
				rotation = scene.getRotation();
				scale = scene.getScale();
				label = scene.getLabel();
				
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
					<idNumber>{scene.getIDNumber()}</idNumber>
					<label>{label}</label>
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
		
		private static function generateXMLAnimation(scene:FlarasScene):XML
		{
			var xml:XML;
			var animationScene:AnimationScene;
			var hasAnimation:uint;
			var period:Number;
			var rotationAxis:uint;
			var radiusA:Number;
			var radiusB:Number;
			var rotationDirection:int;
			
			if (scene.getAnimation())
			{
				animationScene = scene.getAnimation();
				hasAnimation = 1;
				period = animationScene.getPeriod();
				rotationAxis = animationScene.getRotationAxis();
				radiusA = animationScene.getRadiusA();
				radiusB = animationScene.getRadiusB();
				rotationDirection = animationScene.getRotationDirection();
			}
			else
			{
				hasAnimation = 0;
				period = 0;
				rotationAxis = 0;
				radiusA = 0;
				radiusB = 0;
				rotationDirection = 0;
			}
			
			xml = new XML();	
			
			xml = 
				<animation>
						<hasAnimation>{hasAnimation}</hasAnimation>
						<period>{period}</period>
						<rotationAxis>{rotationAxis}</rotationAxis>
						<radius>{radiusA}</radius>
						<radiusB>{radiusB}</radiusB>
						<rotationDirection>{rotationDirection}</rotationDirection>
					</animation>
					
			return xml;
		}
	}
}