package io.metteo.structure;

import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Arrays;
import java.util.stream.Collectors;

import org.apache.commons.configuration2.Configuration;
import org.apache.commons.configuration2.PropertiesConfiguration;
import org.apache.commons.configuration2.builder.FileBasedConfigurationBuilder;
import org.apache.commons.configuration2.builder.fluent.Parameters;
import org.apache.commons.configuration2.ex.ConfigurationException;

public class Structure {

	public static void main(String[] args) {
		
		String appHome = System.getProperty("app.home");
		if (appHome == null) { 
			appHome = System.getProperty("user.dir"); //default for ide style of launching
			System.setProperty("app.home", appHome);
		}
		
		String configDir = System.getProperty("app.config.dir");
		if (configDir == null) { 
			configDir = "../dist/src/config";
			System.setProperty("app.config.dir", configDir);
		}
		
		String configFile = System.getProperty("app.config.file");
		if (configFile == null) { 
			configFile = "structure.app.properties";
			System.setProperty("app.config.dir", configFile);
		}
		
		Path configPath = Paths.get(appHome, configDir, configFile).normalize();
		System.out.println(configPath);
		
		Parameters params = new Parameters();

		FileBasedConfigurationBuilder<PropertiesConfiguration> builder = new FileBasedConfigurationBuilder<>(
				PropertiesConfiguration.class).configure(params.properties().setFile(configPath.toFile()));
		
		try {
			Configuration config = builder.getConfiguration();
			
			System.out.println(config.getString("app.bin.dir"));
		} catch (ConfigurationException e) {
			e.printStackTrace(System.out);
		}
		
		System.out.println("structure " + Arrays.stream(args).collect(Collectors.joining(" ")));
	}

}
