SELECT doc_id, doc_name, file_name, edms_doc, doc_type, edms_id, size, crtd_by, updated_by, created_at, updated_at FROM yono_dcmnt.dcmnt_mstr; "DC_026" "Annexture_A" "Annexture_A" "Annexture_A" "Annexture_A" "10" 500 "SYSTEM" "SYSTEM" "2025-07-03 14:08:34.200752+05:30" "2025-07-03 14:08:34.200752" "DC_027" "Annexture_B" "Annexture_B" "Annexture_B" "Annexture_B" "11" 500 "SYSTEM" "SYSTEM" "2025-07-03 14:08:34.200752+05:30" "2025-07-03 14:08:34.200752" create insert script


INSERT INTO yono_dcmnt.dcmnt_mstr 
(doc_id, doc_name, file_name, edms_doc, doc_type, edms_id, size, crtd_by, updated_by, created_at, updated_at)
VALUES 
('DC_026', 'Annexture_A', 'Annexture_A', 'Annexture_A', 'Annexture_A', '10', 500, 'SYSTEM', 'SYSTEM', 
 '2025-07-03 14:08:34.200752+05:30', '2025-07-03 14:08:34.200752+05:30'),
('DC_027', 'Annexture_B', 'Annexture_B', 'Annexture_B', 'Annexture_B', '11', 500, 'SYSTEM', 'SYSTEM', 
 '2025-07-03 14:08:34.200752+05:30', '2025-07-03 14:08:34.200752+05:30');


package com.sbi.yono.document.savingsaccount.edms.phototrigger;

import static org.mockito.Mockito.*;

import java.util.Arrays;
import java.util.List;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import com.sbi.yono.document.batch.dto.PhotoRetryDto;

class PhotoTriggerCallTest {

    private PhotoRetryTrigger photoRetryTrigger;
    private PhotoTriggerCall photoTriggerCall;

    @BeforeEach
    void setUp() {
        photoRetryTrigger = mock(PhotoRetryTrigger.class);
        photoTriggerCall = new PhotoTriggerCall(photoRetryTrigger);
    }

    @Test
    void testPhotoTriggerInit_shouldCallTriggerForEachDto() {
        // Arrange DTOs
        PhotoRetryDto dto1 = new PhotoRetryDto();
        dto1.setRefNo("REF001");
        dto1.setBaseSixtyFour("base1");

        PhotoRetryDto dto2 = new PhotoRetryDto();
        dto2.setRefNo("REF002");
        dto2.setBaseSixtyFour("base2");

        List<PhotoRetryDto> list = Arrays.asList(dto1, dto2);

        // Act
        photoTriggerCall.photoTriggerInit(list);

        // Assert – verify callPhotoTrigger invoked twice
        verify(photoRetryTrigger, times(1)).callPhotoTrigger(dto1);
        verify(photoRetryTrigger, times(1)).callPhotoTrigger(dto2);

        // Ensure no extra interactions
        verifyNoMoreInteractions(photoRetryTrigger);
    }

    @Test
    void testPhotoTriggerInit_withEmptyList_shouldNotInvokeTrigger() {
        // Arrange
        List<PhotoRetryDto> emptyList = List.of();

        // Act
        photoTriggerCall.photoTriggerInit(emptyList);

        // Assert
        verifyNoInteractions(photoRetryTrigger);
    }
}