package cn.edu.zju.dao;

import cn.edu.zju.dto.DrugGeneAssociation;
import org.junit.Assert;
import org.junit.Test;

import java.util.List;

/**
 * Lightweight DAO checks for Module 2 (run against a populated local {@code biomed}).
 * <p>
 * <b>For your report (Test section):</b> cite these as automated regression checks for
 * counting, pagination bounds, and detail round-trip consistency after schema/seed changes.
 */
public class DrugGeneSearchDaoTest {

    private final DrugGeneSearchDao dao = new DrugGeneSearchDao();

    @Test
    public void countEqualsSumAcrossAllPages() {
        int total = dao.countByKeyword("");
        final int pageSize = 100;
        int pages = total == 0 ? 0 : (int) Math.ceil(total / (double) pageSize);
        int sum = 0;
        for (int p = 1; p <= pages; p++) {
            sum += dao.searchByKeyword("", p, pageSize).size();
        }
        Assert.assertEquals("COUNT(*) should equal sum of LIMIT/OFFSET pages", total, sum);
    }

    @Test
    public void pageSizeIsRespected() {
        List<DrugGeneAssociation> page = dao.searchByKeyword("", 1, 7);
        Assert.assertTrue("Server-side pagination should cap rows", page.size() <= 7);
    }

    @Test
    public void detailRoundTripForFirstAssociation() {
        List<DrugGeneAssociation> first = dao.searchByKeyword("", 1, 1);
        Assert.assertFalse("Seed SQL should provide at least one association", first.isEmpty());
        DrugGeneAssociation row = first.get(0);
        DrugGeneAssociation again = dao.findByDrugAndGene(row.getDrugId(), row.getGeneId());
        Assert.assertNotNull(again);
        Assert.assertEquals(row.getDrugId(), again.getDrugId());
        Assert.assertEquals(row.getGeneId(), again.getGeneId());
    }

    @Test
    public void nonsenseKeywordReturnsZeroCount() {
        Assert.assertEquals(0, dao.countByKeyword("__no_such_drug_gene_keyword__zz__"));
    }
}
