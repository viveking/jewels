package com.affixus.util;

import java.io.File;
import java.io.IOException;
import java.text.DecimalFormat;
import java.util.Map;

import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.JsonGenerator;
import org.codehaus.jackson.JsonParseException;
import org.codehaus.jackson.Version;
import org.codehaus.jackson.impl.JsonWriteContext;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.map.SerializerProvider;
import org.codehaus.jackson.map.TypeSerializer;
import org.codehaus.jackson.map.module.SimpleModule;

public class JacksonDoubleArrayTest
{
    private static DecimalFormat df = new DecimalFormat( "0.##E0" );

    @SuppressWarnings("deprecation")
	public static class MyDoubleSerializer extends org.codehaus.jackson.map.ser.ScalarSerializerBase<Double>
    {
        protected MyDoubleSerializer()
        {
            super( Double.class );
        }

        @Override
        public final void serializeWithType( Double value, JsonGenerator jgen, SerializerProvider provider, TypeSerializer typeSer ) throws IOException,
                JsonGenerationException
        {
            serialize( value, jgen, provider );
        }

        @Override
        public void serialize( Double value, JsonGenerator jgen, SerializerProvider provider ) throws IOException, JsonGenerationException
        {
            if ( Double.isNaN( value ) || Double.isInfinite( value ) )
            {
                jgen.writeNumber( 0 ); // For lack of a better alternative in JSON
                return;
            }

            String x = df.format( value );
            if ( x.contains( "E" ) )
            {
                x = x.substring( 0, x.indexOf("E") );
            }
            JsonWriteContext ctx = (JsonWriteContext)jgen.getOutputContext();
            ctx.writeValue();
            if ( jgen.getOutputContext().getCurrentIndex() > 0 )
            {
                x = ":" + x;
            }
            jgen.writeRaw( x );
        }

        /*@Override
        public JsonNode getSchema( SerializerProvider provider, Type typeHint )
        {
            return createSchemaNode( "number", true );
        }*/
    }

    @SuppressWarnings("unchecked")
    private static Map<String, Object> load() throws JsonParseException, JsonMappingException, IOException
    {
        ObjectMapper loader = new ObjectMapper();
        return (Map<String, Object>)loader.readValue( new File( "C://x.json" ), Map.class );
    }

    
    public static void main(String[] args) throws JsonGenerationException, JsonMappingException, JsonParseException, IOException {
    	ObjectMapper mapper = new ObjectMapper();
        SimpleModule module = new SimpleModule( "StatsModule", new Version( 0, 1, 0, "alpha" ) );
        module.addSerializer( Double.class, new MyDoubleSerializer() );
        mapper.registerModule( module );
        String out = mapper.writeValueAsString( load() );
        System.out.println(out);
 
	}
    public void test1() throws JsonGenerationException, JsonMappingException, IOException
    {
        ObjectMapper mapper = new ObjectMapper();
        SimpleModule module = new SimpleModule( "StatsModule", new Version( 0, 1, 0, "alpha" ) );
        module.addSerializer( Double.class, new MyDoubleSerializer() );
        mapper.registerModule( module );
        String out = mapper.writeValueAsString( load() );
        System.out.println( out.length() );
    }
}